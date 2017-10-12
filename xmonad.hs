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
import XMonad.Actions.PhysicalScreens

import Data.Maybe

middle :: [a] -> [a]
middle l@(_:_:_:_) = middle $ tail $ init l
middle l           = l

xscreens :: X ScreenId
xscreens = generator >>= return . head . middle . catMaybes
   where generator = (sequence $ map getScreen [0..20])

main = do
    let middleBar = xscreens >>= \x -> spawnDzen2Bar x "-dock -ta l -h 20"
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

