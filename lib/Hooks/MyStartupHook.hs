module Hooks.MyStartupHook(myStartupHook) where

import System.Directory(getHomeDirectory)
import System.FilePath
import XMonad
import XMonad.Util.SpawnNamedPipe(spawnNamedPipe)
import XMonad.Util.Run

import Hooks.MyLogHook(mainBarPipeName)

import DZenBar
import Config.XScreens

configDir :: FilePath -> FilePath -> FilePath
configDir home config = home </> baseDir </> config
  where baseDir = ".xmonad" </> "config"

conkyConfig :: FilePath -> FilePath -> FilePath
conkyConfig home = ((configDir home conkyDir) </>)
  where conkyDir = "conky"

menuBars :: FilePath -> [ScreenId] -> [DZenBar]
menuBars home screens = let
    leftScreen =  (head screens)
    rightScreen = (last screens)
    config x = Just (conkyConfig home x)
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

topBar :: ScreenId -> DZenBar
topBar screen = newDZenBar
      { xscreen = screen
      , height  = Just 18
      , align   = Just DLeft
      }

middle :: [a] -> [a]
middle l@(_:_:_:_) = middle $ tail $ init l
middle l           = l

spawnAllBars :: [ScreenId] -> FilePath -> X ()
spawnAllBars screens home =
    do spawnNamedPipe middleScreen mainBarPipeName
       sequence $ map (spawn . show) (menuBars home $ sideScreens)
       return ()
  where middleScreen = show $ topBar $ head screens -- (show $ topBar (head . middle $ screens))
        sideScreens = tail screens

myStartupHook :: X ()
myStartupHook =
 do screens <- xscreens
    home <- liftIO getHomeDirectory
    spawnAllBars screens home
    safeSpawn "stalonetray" [ "-c", (configDir home "stalonetrayrc")]
