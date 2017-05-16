module Hooks.MyStartupHook(myStartupHook) where
import System.IO
import System.Exit
import XMonad

import XMonad.Util.Run

myStartupHook :: X ()
myStartupHook  = do
    spawn "conky -c /home/mkr/.xmonad/config/leftConky.lua | dzen2 -e 'mouse2=' -xs 2 -h 18 -dock -ta r"
    spawn "conky -c /home/mkr/.xmonad/config/rightConky.lua | dzen2 -e 'mouse2=' -xs 4 -h 18 -w 1830 -dock -ta l"
    spawn "stalonetray -c /home/mkr/.xmonad/config/stalonetrayrc"