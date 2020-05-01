module Entities.Room
  ( -- * Rooms
    bar
  , foyer
  ) where

import qualified Data.HashMap.Strict as HM
import qualified Data.Vector         as V

import           Entities.Action
import           Entities.Object
import           Types.Room

foyer :: Room
foyer = Room { name = "Foyer"
             , description = "This empty room has doors to the south and west, also an unusable exit to the north. There is nobody else around."
             , roomID = RoomID 1
             , north = Nothing
             , south = Just (RoomID 2)
             , east = Nothing
             , west = Nothing
             , objects = V.empty
             , actions = foyerActions
             , properties = HM.fromList []
             }

bar :: Room
bar = Room { name = "Bar"
           , description = "An unlit room, south of the foyer."
           , roomID = RoomID 2
           , north = Just (RoomID 1)
           , east = Nothing
           , west = Nothing
           , south = Nothing
           , objects = V.singleton brassHook
           , actions = HM.empty
           , properties = HM.fromList [(Lit, Off)]
           }
