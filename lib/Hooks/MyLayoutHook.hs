module Hooks.MyLayoutHook(myLayoutHook) where

import XMonad.Hooks.ManageDocks
import XMonad
import XMonad.Layout

myLayoutHook = avoidStruts $ layoutHook def
