module Hooks.MyStartupHook(myStartupHook) where
import System.IO
import System.Exit
import XMonad

import XMonad.Util.Run
import DZenBar
import XMonad.Util.SpawnNamedPipe

import Config.XScreens

import System.Directory(getHomeDirectory)

conkyConfig home x = home ++ "/.xmonad/config/conky/" ++ x

menuBars :: FilePath -> [ScreenId] -> [DZenBar]
menuBars h screens = let
    leftScreen =  (head screens)
    rightScreen = (last screens)
    config x = Just (conkyConfig h x)
    leftBar = newDZenBar
      { conkyConfigFile = config "leftConky.lua"
      , xscreen         = leftScreen
      , position        = Just (500, 0)
      , width           = Just 1420
      , height          = Just 18
      , align           = Just DRight
      }
    uptimeBar = newDZenBar
      { conkyConfigFile = config "uptimeBar.lua"
      , xscreen         = leftScreen
      , position        = Just (0, 0)
      , width           = Just 200
      , height          = Just 18
      , align           = Just DLeft
      }
    ramBar = newDZenBar
      { conkyConfigFile = config "ramBar.lua"
      , xscreen         = leftScreen
      , position        = Just (200, 0)
      , width           = Just 300
      , height          = Just 18
      , align           = Just DLeft
      }
    rightBar = newDZenBar
      { conkyConfigFile = config "rightConky.lua"
      , xscreen         = rightScreen
      , position        = Just (0, 0)
      , width           = Just 1630
      , height          = Just 18
      , align           = Just DLeft
      }
    timeBar = newDZenBar
      { conkyConfigFile = config "timeBar.lua"
      , xscreen         = rightScreen
      , position        = Just (1630, 0)
      , width           = Just 200
      , height          = Just 18
      , align           = Just DRight
      }
    in [leftBar, rightBar, uptimeBar, ramBar, timeBar]

topBar screen = newDZenBar
      { xscreen = screen
      , height  = Just 18
      , align   = Just DLeft
      }

myStartupHook :: X ()
myStartupHook  = do
    screens <- xscreens
    home <- liftIO getHomeDirectory
    spawnNamedPipe (show $ topBar (head . middle $ screens)) "topBar"

    sequence $ map (spawn . show) (menuBars home $ screens)
    spawn $ "stalonetray -c " ++ home ++ "/.xmonad/config/stalonetrayrc"
  where middle :: [a] -> [a]
        middle l@(_:_:_:_) = middle $ tail $ init l
        middle l           = l
