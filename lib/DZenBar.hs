module DZenBar where

--     spawn "conky -c /home/mkr/.xmonad/config/leftConky.lua | dzen2 -e 'mouse2=' -xs 2 -h 18 -dock -ta r"

import XMonad
import Data.List

x `piped` y = x ++ " | " ++ y

data DZenBarAlign = DLeft | DRight | DCenter

data DZenBar = DZenBar
  { conkyConfigFile :: Maybe String
  , xscreen :: ScreenId
  , position :: Maybe (Integer, Integer)
  , width :: Maybe Integer
  , height :: Maybe Integer
  , align :: Maybe DZenBarAlign
  }

newDZenBar = DZenBar
  { conkyConfigFile = Nothing
  , xscreen = undefined
  , position = Nothing
  , width = Nothing
  , height = Nothing
  , align = Nothing
  }

instance Show DZenBarAlign where
  show DLeft = "l"
  show DRight = "r"
  show DCenter = "c"

instance Show DZenBar where
  show x = case conkyConfigFile x of
              Just f ->  ("conky -c '" ++ f ++ "'")  `piped` dzen2Command
              Nothing -> dzen2Command
    where screenFlag = "-xs " ++ (let (S xs) = xscreen x in show (xs + 1))
          xPositionFlag = case position x of
                            Just pos -> "-x " ++ (show $ fst $ pos)
                            Nothing -> ""
          yPositionFlag = case position x of
                            Just pos -> "-y " ++ (show $ snd $ pos)
                            Nothing -> ""
          widthFlag = case width x of
                            Just w -> "-w " ++  (show $ w)
                            Nothing -> ""
          heightFlag = case height x of
                            Just h -> "-h " ++ (show $ h)
                            Nothing -> ""
          alignFlag = case align x of
                            Just a -> "-ta " ++ (show $ a)
                            Nothing -> ""
          dzen2Command = intercalate " " $ filter (not . null)
                        [ "dzen2 -dock -e 'mouse2='"
                        , screenFlag
                        , xPositionFlag
                        , yPositionFlag
                        , widthFlag
                        , heightFlag
                        , alignFlag
                        ]