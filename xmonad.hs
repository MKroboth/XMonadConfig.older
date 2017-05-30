import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig
import XMonad.Hooks.ManageDocks(docksEventHook,manageDocks)
import XMonad.Hooks.EwmhDesktops

import TopBars
import Hooks.MyLogHook
import Hooks.MyLayoutHook
import Hooks.MyStartupHook
import Config.MyKeybindings


leftXScreen = 2
middleXScreen = 1
rightXScreen = 3

main :: IO ()
main = do
    middleBar <- spawnDzen2Bar middleXScreen "-dock -ta l -h 20"
    xmonad $ (myConfig middleBar) `removeKeysP` removeKeybindings `additionalKeysP` myKeybindings

myConfig middleBar = ewmh desktopConfig
               { terminal = "terminator"
               , modMask = mod4Mask
               , logHook = myLogHook middleBar
               , layoutHook = myLayoutHook
               , handleEventHook = docksEventHook <+> handleEventHook def
               , manageHook = manageHook def <+> manageDocks
               , startupHook = myStartupHook
               }

