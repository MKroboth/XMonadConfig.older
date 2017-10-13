module Hooks.MyStartupHook(myStartupHook) where
import System.IO
import System.Exit
import XMonad

import XMonad.Util.Run
import DZenBar
import XMonad.Util.SpawnNamedPipe

import Config.XScreens

import System.Directory(getHomeDirectory)

middle :: [a] -> [a]
middle l@(_:_:_:_) = middle $ tail $ init l
middle l           = l

conkyConfig home x = home ++ "/.xmonad/config/conky/" ++ x

menuBars :: FilePath -> [ScreenId] -> [DZenBar]
menuBars h screens = let
    leftScreen =  (head screens)
    rightScreen = (last screens)
    config x = Just (conkyConfig h x)
    leftBar = newDZenBar
      { conkyConfigFile = config "leftConky.lua"
      , xscreen = leftScreen
      , position = (500, 0)
      , width = 1420
      , height = 18
      , align = DRight
      }
    uptimeBar = newDZenBar
      { conkyConfigFile = config "uptimeBar.lua"
      , xscreen = leftScreen
      , position = (0, 0)
      , width = 200
      , height = 18
      , align = DLeft
      }
    ramBar = newDZenBar
      { conkyConfigFile = config "ramBar.lua"
      , xscreen = leftScreen
      , position = (200, 0)
      , width = 300
      , height = 18
      , align = DLeft
      }
    rightBar = newDZenBar
      { conkyConfigFile = config "rightConky.lua"
      , xscreen = rightScreen
      , position = (0, 0)
      , width = 1630
      , height = 18
      , align = DLeft
      }
    timeBar = newDZenBar
      { conkyConfigFile = config "timeBar.lua"
      , xscreen = rightScreen
      , position = (1630, 0)
      , width = 200
      , height = 18
      , align = DRight
      }
    in [leftBar, rightBar, uptimeBar, ramBar, timeBar]

topBar screen = newDZenBar
               { xscreen = screen
               , position = (0, 0)
               , width = 1920
               , height = 18
               , align = DLeft
               }

myStartupHook :: X ()
myStartupHook  = do
    screens <- xscreens
    home <- liftIO getHomeDirectory
    spawnNamedPipe (show $ topBar (head . middle $ screens)) "topBar"

    sequence $ map (spawn . show) (menuBars home $ screens)
    spawn $ "stalonetray -c " ++ home ++ "/.xmonad/config/stalonetrayrc"
