module Config.MyKeybindings(myKeybindings) where
import XMonad
import XMonad.Util.Run

import qualified SpecialKeys

(>>>) a b = (a,b)

myKeybindings :: [(String, X ())]

myKeybindings = [ "M-x i j" >>> safeSpawn "intellij-idea-ultimate-edition" []
                , "M-x w" >>> safeSpawn "google-chrome-stable" []
                , SpecialKeys.xf86AudioPlay  >>> safeSpawn "mpc" ["toggle"]
                , SpecialKeys.xf86AudioNext  >>> safeSpawn "mpc" ["next"]
                , SpecialKeys.xf86AudioPrev  >>> safeSpawn "mpc" ["prev"]
                , SpecialKeys.xf86AudioLowerVolume >>> safeSpawn "mpc" ["seek", "-5"]
                , SpecialKeys.xf86AudioRaiseVolume >>> safeSpawn "mpc" ["seek", "+5"]
                ]