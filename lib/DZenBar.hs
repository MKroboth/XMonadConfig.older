module DZenBar where

--     spawn "conky -c /home/mkr/.xmonad/config/leftConky.lua | dzen2 -e 'mouse2=' -xs 2 -h 18 -dock -ta r"

import XMonad

x `piped` y = x ++ " | " ++ y

data DZenBarAlign = DLeft | DRight | DCenter

data DZenBar = DZenBar
  { conkyConfigFile :: Maybe String
  , xscreen :: ScreenId
  , position :: (Integer, Integer)
  , width :: Integer
  , height :: Integer
  , align :: DZenBarAlign
  }

newDZenBar = DZenBar
  { conkyConfigFile = Nothing
  , xscreen = undefined
  , position = undefined
  , width = undefined
  , height = undefined
  , align = undefined
  }

instance Show DZenBarAlign where
  show DLeft = "l"
  show DRight = "r"
  show DCenter = "c"

instance Show DZenBar where
  show x = case conkyConfigFile x of
    Just f ->  ("conky -c '" ++ f ++ "'")  `piped` dzen2Command
    Nothing -> dzen2Command
    where dzen2Command = "dzen2 -dock -e 'mouse2=' -xs " ++
                             (let (S xs) = xscreen x in show (xs + 1)) ++
                             " -x " ++ (show $ fst $ position x) ++ " -y " ++ (show $ snd $ position x) ++ " -w " ++ (show $ width x) ++ " -h " ++
                             (show $ height x) ++ " -ta " ++ (show $ align x)