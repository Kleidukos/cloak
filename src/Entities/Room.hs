module Entities.Room
  (

  ) where

import qualified Data.HashMap.Strict as HM
import qualified Data.Vector         as V

import           Entities.Action
import           Types
import           Types.Room

foyer :: Room
foyer = Room { name = "Foyer"
             , description = "This empty room has doors to the south and west, also an unusable exit to the north. There is nobody else around."
             , roomID = RoomID "Foyer"
             , north = Nothing
             , south = Just (RoomID "Bar")
             , east = Nothing
             , west = Nothing
             , objects = V.empty
             , actions = HM.fromList [("Go to the bar", goToTheBar)]
             }

bar :: Room
bar = Room { name = "Bar"
           , description = "An unlit room, south of the foyer."
           , roomID = RoomID "Bar"
           , north = Just (RoomID "Foyer")
           , east = Nothing
           , west = Nothing
           , south = Nothing
           , objects = V.singleton brassHook
           , actions = HM.fromList [("Hook your cloak", hookTheCloak)]
           }
