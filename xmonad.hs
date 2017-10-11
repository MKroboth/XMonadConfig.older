import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig
import XMonad.Hooks.ManageDocks(docksEventHook,manageDocks)
import XMonad.Hooks.EwmhDesktops

import TopBars
import Hooks.MyLogHook
import Hooks.MyLayoutHook
import Hooks.MyStartupHook
import Hooks.MyManageHook
import Config.MyKeybindings
import Config.XScreens


main :: IO ()
main = do
    screens <- detectXScreens
    middleBar <- spawnDzen2Bar middleXScreen "-dock -ta l -h 20"
    xmonad $ (myConfig middleBar) `removeKeysP` removeKeybindings `additionalKeysP` (myKeybindings screens)

myConfig middleBar = ewmh desktopConfig
               { terminal = "xterm"
               , modMask = mod4Mask
               , logHook = myLogHook middleBar
               , layoutHook = myLayoutHook
               , handleEventHook = docksEventHook <+> handleEventHook def <+> fullscreenEventHook
               , manageHook = myManageHook
               , startupHook = myStartupHook
               }

