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

middleBar = do x <- xscreens
               spawnDzen2Bar (head $ middle x) "-dock -ta l -h 20"

main = do
    xmonad $ (myConfig middleBar) `removeKeysP` removeKeybindings `additionalKeysP` (myKeybindings)

myConfig middleBar = ewmh desktopConfig
               { terminal = "konsole"
               , modMask = mod4Mask
               , logHook = myLogHook middleBar
               , layoutHook = myLayoutHook
               , handleEventHook = docksEventHook <+> handleEventHook def <+> fullscreenEventHook
               , manageHook = myManageHook
               , startupHook = myStartupHook
               }

