module Hooks.MyLogHook(myLogHook, mainBarPipeName) where

import XMonad
import XMonad.Util.Run

import XMonad.Hooks.DynamicLog
import System.IO
import XMonad.Util.SpawnNamedPipe

import XMonad.Hooks.FadeInactive

mainBarPipeName = "mainTopBarPipe"

titleBar :: Handle -> X ()
titleBar h =
 dynamicLogWithPP $ def
    {
        ppCurrent           =   dzenColor "#ebac54" "#111111" . pad
      , ppVisible           =   dzenColor "white" "#111111" . pad
      , ppHidden            =   dzenColor "white" "#111111" . pad
      , ppHiddenNoWindows   =   dzenColor "#7b7b7b" "#111111" . pad
      , ppUrgent            =   dzenColor "#ff0000" "#111111" . pad
      , ppWsSep             =   ""
      , ppSep               =   " | "
      , ppLayout            =   dzenColor "#ebac54" "#111111" .
                                \x -> x
      , ppTitle             =   (" " ++) . dzenColor "white" "#111111" . dzenEscape
      , ppOutput            =   hPutStrLn h
    }

showTitleBar :: Maybe Handle -> X ()
showTitleBar (Just h) = titleBar h
showTitleBar Nothing = return ()

fadeInactive = fadeInactiveLogHook fadeAmount
  where fadeAmount = 0.8

myLogHook :: X ()
myLogHook = do getNamedPipe mainBarPipeName >>= showTitleBar
             --fadeInactive