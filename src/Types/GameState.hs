module Types.GameState
  ( GameState (..)

  ) where

import           Types.Room

data GameState = GS { currentRoom :: RoomID
                    , rooms       :: HashMap RoomID Room
                    } deriving (Show, Eq)
