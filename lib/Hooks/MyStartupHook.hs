module Hooks.MyStartupHook(myStartupHook) where
import System.IO
import System.Exit
import XMonad

import XMonad.Util.Run
import DZenBar

import Config.XScreens

import System.Directory(getHomeDirectory)

conkyConfig home x = home ++ "/.xmonad/config/conky/" ++ x


menuBars :: FilePath -> [DZenBar]
menuBars h = let
    config = conkyConfig $ h
    leftBar = DZenBar
      { conkyConfigFile = config "leftConky.lua"
      , xscreen = leftXScreen
      , position = (500, 0)
      , width = 1420
      , height = 18
      , align = DRight
      }
    uptimeBar = DZenBar
      { conkyConfigFile = config "uptimeBar.lua"
      , xscreen = leftXScreen
      , position = (0, 0)
      , width = 200
      , height = 18
      , align = DLeft
      }
    ramBar = DZenBar
      { conkyConfigFile = config "ramBar.lua"
      , xscreen = leftXScreen
      , position = (200, 0)
      , width = 300
      , height = 18
      , align = DLeft
      }
    rightBar = DZenBar
      { conkyConfigFile = config "rightConky.lua"
      , xscreen = rightXScreen
      , position = (0, 0)
      , width = 1630
      , height = 18
      , align = DLeft
      }
    timeBar = DZenBar
      { conkyConfigFile = config "timeBar.lua"
      , xscreen = rightXScreen
      , position = (1630, 0)
      , width = 200
      , height = 18
      , align = DRight
      }
    in [leftBar, rightBar, uptimeBar, ramBar, timeBar]

myStartupHook :: X ()
myStartupHook  = do
    home <- liftIO getHomeDirectory
    sequence $ map (\x -> spawn $ show x) (menuBars home)
    spawn $ "stalonetray -c " ++ home ++ "/.xmonad/config/stalonetrayrc"