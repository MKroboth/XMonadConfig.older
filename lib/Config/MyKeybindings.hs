module Config.MyKeybindings(myKeybindings, removeKeybindings) where
import XMonad
import XMonad.Util.Run
import qualified XMonad.StackSet as W

import XMonad.Actions.PhysicalScreens
import System.Exit(exitSuccess)

import SpecialKeys

(>>>) a b = (a,b)

myKeybindings :: [(String, X ())]

mpc  x   = safeSpawn "mpc" [x]
mpc' x i = safeSpawn "mpc" [x, i]

seekAmount = 5

launchApplication :: String -> X ()
launchApplication = flip safeSpawn $ []

k x = "M-x " ++ x


workspaceKeys =
  [ (mask ++ "M-" ++ [key], action scr)
  | (key, scr)  <- zip "wer" [0..]
  , (action, mask) <- [ (viewScreen, "")
                      , (sendToScreen, "S-")
                      ]
  ]

applicationKeybindings =
  [ k"i j" >>> launchApplication "idea.sh"
  , k"i c" >>> launchApplication "clion"
  , k"w"   >>> launchApplication "google-chrome-stable"
  , k"e"   >>> launchApplication "emacs"
  ]

musicControlKeybindings =
  [ xf86AudioPlay        >>> mpc  "toggle"
  , xf86AudioNext        >>> mpc  "next"
  , xf86AudioPrev        >>> mpc  "prev"
  , xf86AudioLowerVolume >>> mpc' "seek" ("-" ++ show seekAmount)
  , xf86AudioRaiseVolume >>> mpc' "seek" ("+" ++ show seekAmount)
  ]

xmonadKeybindings = [ "M-S-<Escape>" >>> liftIO exitSuccess]

removeKeybindings = [ "M-S-q" ]
myKeybindings = musicControlKeybindings ++ applicationKeybindings ++ workspaceKeys ++ xmonadKeybindings