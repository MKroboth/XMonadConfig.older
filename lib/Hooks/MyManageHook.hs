module Hooks.MyManageHook(myManageHook) where
import XMonad.Hooks.ManageDocks(manageDocks)
import XMonad.Hooks.ManageHelpers

import XMonad

myManageHook = composeAll
    [ manageHook def
    , (isFullscreen --> doFullFloat)
    , manageDocks
    ]