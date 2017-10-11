module Config.MyKeybindings(myKeybindings, removeKeybindings) where
import XMonad
import XMonad.Util.Run
import Config.XScreens
import qualified XMonad.StackSet as W


import SpecialKeys

(>>>) a b = (a,b)

myKeybindings :: [ScreenId] -> [(String, X ())]

mpc x = safeSpawn "mpc" [x]
mpc' x i = safeSpawn "mpc" [x, i]

seekAmount = 5

launchApplication :: String -> X ()
launchApplication = flip safeSpawn $ []

k x = "M-x " ++ x

workspaceKeys xscreens = [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
                | (key, scr)  <- zip "wer" xscreens
                , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
                ]

applicationKeybindings = [ k"i j" >>> launchApplication "idea.sh"
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

removeKeybindings = [ "M-Shift-q" ]
myKeybindings scrs = musicControlKeybindings ++ applicationKeybindings ++ (workspaceKeys scrs)