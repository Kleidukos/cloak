module Entities
  ( module Entities.Object
  , module Entities.Room
  , module Entities.Action
  , startingWorld
  ) where

import qualified Data.HashMap.Strict as HM

import           Entities.Action
import           Entities.Object
import           Entities.Room
import           Types.GameState
import           Types.Room

startingWorld :: GameState
startingWorld =
  GS{ currentRoom = roomID foyer
    , rooms = HM.fromList [(roomID foyer, foyer),
                           (roomID bar, bar)]
    }
