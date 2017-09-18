module Config.MyKeybindings(myKeybindings, removeKeybindings) where
import XMonad
import XMonad.Util.Run
import Config.XScreens
import qualified XMonad.StackSet as W


import qualified SpecialKeys

(>>>) a b = (a,b)

myKeybindings :: [(String, X ())]

mpc x = safeSpawn "mpc" [x]
mpcArg x i = safeSpawn "mpc" [x, i]

seekAmount = 5

removeKeybindings = [ "M-shift-q" ]
myKeybindings = [ "M-x i j" >>> safeSpawn "intellij-idea-ultimate-edition" []
                , "M-x i c" >>> safeSpawn "clion" []
                , "M-x w" >>> safeSpawn "google-chrome-stable" []
                , "M-x e" >>> safeSpawn "emacs" []
                , SpecialKeys.xf86AudioPlay  >>> mpc "toggle"
                , SpecialKeys.xf86AudioNext  >>> mpc "next"
                , SpecialKeys.xf86AudioPrev  >>> mpc "prev"
                , SpecialKeys.xf86AudioLowerVolume >>> mpcArg "seek" ("-" ++ show seekAmount)
                , SpecialKeys.xf86AudioRaiseVolume >>> mpcArg "seek" ("+" ++ show seekAmount)
                ]
                ++
                [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
                     | (key, scr)  <- zip "wer" [2, 1, 0] -- was [0..] *** change to match your screen order ***
                     , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
                ]
