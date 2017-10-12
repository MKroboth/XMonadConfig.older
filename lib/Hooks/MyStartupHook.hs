module Hooks.MyStartupHook(myStartupHook) where
import System.IO
import System.Exit
import XMonad

import XMonad.Util.Run
import DZenBar

import Data.Maybe

import System.Directory(getHomeDirectory)
import XMonad.Actions.PhysicalScreens

conkyConfig home x = home ++ "/.xmonad/config/conky/" ++ x

xscreens :: X [ScreenId]
xscreens = generator >>= return . catMaybes
  where generator = (sequence $ map getScreen [0..10])

menuBars :: FilePath -> [ScreenId] -> [DZenBar]
menuBars h screens = let
    leftScreen =  (head screens)
    rightScreen = (last screens)
    config = conkyConfig $ h
    leftBar = DZenBar
      { conkyConfigFile = config "leftConky.lua"
      , xscreen = leftScreen
      , position = (500, 0)
      , width = 1420
      , height = 18
      , align = DRight
      }
    uptimeBar = DZenBar
      { conkyConfigFile = config "uptimeBar.lua"
      , xscreen = leftScreen
      , position = (0, 0)
      , width = 200
      , height = 18
      , align = DLeft
      }
    ramBar = DZenBar
      { conkyConfigFile = config "ramBar.lua"
      , xscreen = leftScreen
      , position = (200, 0)
      , width = 300
      , height = 18
      , align = DLeft
      }
    rightBar = DZenBar
      { conkyConfigFile = config "rightConky.lua"
      , xscreen = rightScreen
      , position = (0, 0)
      , width = 1630
      , height = 18
      , align = DLeft
      }
    timeBar = DZenBar
      { conkyConfigFile = config "timeBar.lua"
      , xscreen = rightScreen
      , position = (1630, 0)
      , width = 200
      , height = 18
      , align = DRight
      }
    in [leftBar, rightBar, uptimeBar, ramBar, timeBar]

myStartupHook :: X ()
myStartupHook  = do
    screens <- xscreens
    home <- liftIO getHomeDirectory
    sequence $ map (\x -> spawn $ show x) (menuBars home screens)
    spawn $ "stalonetray -c " ++ home ++ "/.xmonad/config/stalonetrayrc"