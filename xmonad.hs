import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig
import XMonad.Hooks.ManageDocks(docksEventHook,manageDocks)
import XMonad.Hooks.EwmhDesktops

import Hooks.MyLogHook
import Hooks.MyLayoutHook
import Hooks.MyStartupHook
import Hooks.MyManageHook
import Config.MyKeybindings
import Config.XScreens


main = xmonad $ myConfig `removeKeysP` removeKeybindings `additionalKeysP` (myKeybindings)

myConfig = ewmh desktopConfig
               { terminal = "konsole"
               , modMask = mod4Mask
               , logHook = myLogHook
               , layoutHook = myLayoutHook
               , handleEventHook = docksEventHook <+> handleEventHook def <+> fullscreenEventHook
               , manageHook = myManageHook
               , startupHook = myStartupHook
               }

