module DZenBar where

--     spawn "conky -c /home/mkr/.xmonad/config/leftConky.lua | dzen2 -e 'mouse2=' -xs 2 -h 18 -dock -ta r"

data DZenBarAlign = DLeft | DRight | DCenter

data DZenBar = DZenBar
  { conkyConfigFile :: String
  , xscreen :: Integer
  , position :: (Integer, Integer)
  , width :: Integer
  , height :: Integer
  , align :: DZenBarAlign
  }

instance Show DZenBarAlign where
  show DLeft = "l"
  show DRight = "r"
  show DCenter = "c"

instance Show DZenBar where
  show x = "conky -c '" ++
   (conkyConfigFile x) ++
   "' | dzen2 -dock -e 'mouse2=' -xs " ++
    (show $ xscreen x) ++
    " -x " ++ (show $ fst $ position x) ++ " -y " ++ (show $ snd $ position x) ++ " -w " ++ (show $ width x) ++ " -h " ++
    (show $ height x) ++ " -ta " ++ (show $ align x)