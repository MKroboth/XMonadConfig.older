module Config.XScreens where

import XMonad


detectXScreens :: IO [ScreenId]
detectXScreens = return [0, 2, 1]

leftXScreen = 3
rightXScreen = 2
middleXScreen = 1