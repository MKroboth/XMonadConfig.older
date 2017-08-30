module Hooks.MyStartupHook(myStartupHook) where
import System.IO
import System.Exit
import XMonad

import XMonad.Util.Run
import qualified DZenBar

import Config.XScreens

import System.Directory(getHomeDirectory)

conkyConfig home x = home ++ "/.xmonad/config/conky/" ++ x


menuBars :: FilePath -> [DZenBar.DZenBar]
menuBars h = let
    config = conkyConfig $ h
    leftBar = DZenBar.DZenBar
      { DZenBar.conkyConfigFile = config "leftConky.lua"
      , DZenBar.xscreen = leftXScreen
      , DZenBar.position = (500, 0)
      , DZenBar.width = 1420
      , DZenBar.height = 18
      , DZenBar.align = DZenBar.DRight
      }
    uptimeBar = DZenBar.DZenBar
      { DZenBar.conkyConfigFile = config "uptimeBar.lua"
      , DZenBar.xscreen = leftXScreen
      , DZenBar.position = (0, 0)
      , DZenBar.width = 200
      , DZenBar.height = 18
      , DZenBar.align = DZenBar.DLeft
      }
    ramBar = DZenBar.DZenBar
      { DZenBar.conkyConfigFile = config "ramBar.lua"
      , DZenBar.xscreen = leftXScreen
      , DZenBar.position = (200, 0)
      , DZenBar.width = 300
      , DZenBar.height = 18
      , DZenBar.align = DZenBar.DLeft
      }
    rightBar = DZenBar.DZenBar
      { DZenBar.conkyConfigFile = config "rightConky.lua"
      , DZenBar.xscreen = rightXScreen
      , DZenBar.position = (0, 0)
      , DZenBar.width = 1630
      , DZenBar.height = 18
      , DZenBar.align = DZenBar.DLeft
      }
    timeBar = DZenBar.DZenBar
      { DZenBar.conkyConfigFile = config "timeBar.lua"
      , DZenBar.xscreen = rightXScreen
      , DZenBar.position = (1630, 0)
      , DZenBar.width = 200
      , DZenBar.height = 18
      , DZenBar.align = DZenBar.DRight
      }
    in [leftBar, rightBar, uptimeBar, ramBar, timeBar]

myStartupHook :: X ()
myStartupHook  = do
    home <- liftIO getHomeDirectory
    sequence $ map (\x -> spawn $ show x) (menuBars home)
    spawn "stalonetray -c /home/mkr/.xmonad/config/stalonetrayrc"