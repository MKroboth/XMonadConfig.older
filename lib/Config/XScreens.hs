module Config.XScreens(xscreens) where

import XMonad(X, ScreenId)
import Data.Maybe
import XMonad.Actions.PhysicalScreens(getScreen)

xscreens :: X [ScreenId]
xscreens = generator >>= return . catMaybes
   where generator = (sequence $ map getScreen [0..5])
