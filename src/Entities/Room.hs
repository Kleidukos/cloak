module Entities.Room
  ( -- * Rooms
    bar
  , foyer
    -- * Operations on rooms
  , listActions
  , changeCurrentRoom
  ) where

import qualified Data.HashMap.Strict as HM
import           Data.Maybe          (fromJust)
import qualified Data.Vector         as V

import           Entities.Action
import           Entities.Object
import           Types.Action
import           Types.GameState
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
             , actions = HM.fromList [(ActionID 2, goToTheBar)]
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
           , actions = HM.fromList [(ActionID 1, hookTheCloak)]
           , properties = HM.fromList [(Lit, Off)]
           }

-- | List the available actions for the current room
listActions :: (MonadIO m, MonadState GameState m) => m [Text]
listActions = do
  room <- getCurrentRoom
  let showActions acc actionID action = acc <> [(show actionID :: Text) <> ": " <> (show action :: Text)]
  pure $ HM.foldlWithKey' showActions [] (actions room)

changeCurrentRoom :: (MonadState GameState m) => RoomID -> m ()
changeCurrentRoom newCurrentRoom =
  modify (\GS{rooms} -> GS{currentRoom=newCurrentRoom, rooms})

getCurrentRoom :: (MonadState GameState m) => m Room
getCurrentRoom = do
  GS{rooms, currentRoom} <- get
  pure . fromJust $ HM.lookup currentRoom rooms

