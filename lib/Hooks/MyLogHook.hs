module Hooks.MyLogHook(myLogHook) where

import XMonad
import XMonad.Util.Run

import XMonad.Hooks.DynamicLog
import System.IO

myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ def
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
