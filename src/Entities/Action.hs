module Entities.Action
  ( hookTheCloak
  , foyerActions
  ) where

import qualified Data.HashMap.Strict as HM
import           Data.Maybe          (fromJust)

import           Functions.Room
import           Types.Action
import           Types.GameState
import           Types.Room

foyerActions :: HashMap ActionID (Action RoomID)
foyerActions = HM.fromList [(ActionID 0, Examine (RoomID 0)),
                            (ActionID 1, Go (RoomID 1))
                           ]

hookTheCloak :: MonadState GameState m => m ()
hookTheCloak = do
  cloakroom <- fromJust <$> getRoom (RoomID 3)
  let newCloakroom = setProperty cloakroom Cloak Hooked
  changeRoom (RoomID 3) newCloakroom
  pure ()
