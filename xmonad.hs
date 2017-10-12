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


middle :: [a] -> [a]
middle l@(_:_:_:_) = middle $ tail $ init l
middle l           = l

main = do
 bar <- spawnDzen2Bar (3) "-dock -ta l -h 20"
 xmonad $ (myConfig bar) `removeKeysP` removeKeybindings `additionalKeysP` (myKeybindings)

myConfig middleBar = ewmh desktopConfig
               { terminal = "konsole"
               , modMask = mod4Mask
               , logHook = myLogHook middleBar
               , layoutHook = myLayoutHook
               , handleEventHook = docksEventHook <+> handleEventHook def <+> fullscreenEventHook
               , manageHook = myManageHook
               , startupHook = myStartupHook
               }

