module Hooks.MyLayoutHook(myLayoutHook) where

import XMonad.Hooks.ManageDocks
import XMonad
import XMonad.Layout
import XMonad.Layout.NoBorders(smartBorders)

myLayoutHook = smartBorders . avoidStruts $ layoutHook def
