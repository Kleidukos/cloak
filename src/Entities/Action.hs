module Entities.Action
  ( goToTheBar
  , hookTheCloak
  , foyerActions
  , foyerActionsListing
  ) where

import qualified Data.HashMap.Strict as HM
import           Data.Maybe          (fromJust)

import           Functions.Room
import           Types.Action
import           Types.GameState
import           Types.Room

foyerActions :: (MonadState GameState m, MonadIO m)
             => HashMap ActionID (m ())
foyerActions = HM.fromList [(ActionID 0, describeFoyer), (ActionID 1, goToTheBar)]

foyerActionsListing :: HashMap ActionID Action
foyerActionsListing =
  HM.fromList [ (ActionID 0, Action "Read the room")
              , (ActionID 1, Action "Go to the bar")
              ]

goToTheBar :: (MonadState GameState m, MonadIO m) => m ()
goToTheBar = do
  changeCurrentRoom (RoomID 2)

describeFoyer :: (MonadState GameState m, MonadIO m) => m ()
describeFoyer = do
  putTextLn  "You are in the Foyer of the Opera House"
  pure ()

hookTheCloak :: MonadState GameState m => m ()
hookTheCloak = do
  cloakroom <- fromJust <$> getRoom (RoomID 3)
  let newCloakroom = setProperty cloakroom Cloak Hooked
  changeRoom (RoomID 3) newCloakroom
  pure ()
