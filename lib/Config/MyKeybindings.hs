module Config.MyKeybindings(myKeybindings, removeKeybindings) where
import XMonad
import XMonad.Util.Run
import Config.XScreens
import qualified XMonad.StackSet as W


import SpecialKeys

(>>>) a b = (a,b)

myKeybindings :: [(String, X ())]

mpc x = safeSpawn "mpc" [x]
mpc' x i = safeSpawn "mpc" [x, i]

seekAmount = 5

launchApplication :: String -> X ()
launchApplication = flip safeSpawn $ []

k x = "M-x " ++ x

xscreenOrder = [0, 2, 1] -- was [0..] *** change to match your screen order ***

workspaceKeys = [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
                | (key, scr)  <- zip "wer" xscreenOrder
                , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
                ]

applicationKeybindings = [ k"i j" >>> launchApplication "intellij-idea-ultimate-edition"
                         , k"i c" >>> launchApplication "clion"
                         , k"w"   >>> launchApplication "google-chrome-stable"
                         , k"e"   >>> launchApplication "emacs"
                         ]

musicControlKeybindings = [ xf86AudioPlay        >>> mpc  "toggle"
                          , xf86AudioNext        >>> mpc  "next"
                          , xf86AudioPrev        >>> mpc  "prev"
                          , xf86AudioLowerVolume >>> mpc' "seek" ("-" ++ show seekAmount)
                          , xf86AudioRaiseVolume >>> mpc' "seek" ("+" ++ show seekAmount)
                          ]

removeKeybindings = [ "M-shift-q" ]
myKeybindings = musicControlKeybindings ++ applicationKeybindings ++ workspaceKeys