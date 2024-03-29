module Hooks.MyLayoutHook(myLayoutHook) where

import XMonad.Hooks.ManageDocks
import XMonad
import XMonad.Util.Themes
import XMonad.Layout
import XMonad.Layout.SimpleDecoration
import XMonad.Layout.SimpleFloat

import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Layout.Tabbed
import XMonad.Layout.Spiral


myLayoutHook = smartBorders . avoidStruts $ layouts
  where tabbedLayout =  tabbed shrinkText (theme smallClean)
        layouts =  spiral(16/9) ||| tabbedLayout ||| layoutHook def
