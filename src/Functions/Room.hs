module Functions.Room
  ( listActions
  , changeCurrentRoom
  , getCurrentRoom
  , getRoom
  , setProperty
  , changeRoom
  ) where

import qualified Data.HashMap.Strict as HM
import           Data.Maybe          (fromJust)

import           Types.GameState
import           Types.Room

-- | List the available actions for the current room
listActions :: (MonadIO m, MonadState GameState m) => m [Text]
listActions = do
  room <- getCurrentRoom
  let showActions acc actionID action = acc <> [(show actionID :: Text) <> ": " <> action]
  pure $ HM.foldlWithKey' showActions [] (actions room)

changeCurrentRoom :: (MonadState GameState m, MonadIO m) => RoomID -> m ()
changeCurrentRoom newCurrentRoomID = do
  result <- getRoom newCurrentRoomID
  case result of
    Nothing -> putTextLn "[!] Never heard of that one!" >> pure ()
    Just newCurrentRoom -> do
      modify (\GS{rooms} -> GS{currentRoom=newCurrentRoomID, rooms})
      putTextLn $ "Changed to the " <> name newCurrentRoom
      pure ()

getCurrentRoom :: (MonadState GameState m) => m Room
getCurrentRoom = do
  GS{rooms, currentRoom} <- get
  pure . fromJust $ HM.lookup currentRoom rooms

getRoom :: MonadState GameState m => RoomID -> m (Maybe Room)
getRoom roomID = do
  gets (HM.lookup roomID . rooms)

setProperty :: Room -> Property -> Status -> Room
setProperty room property status = room{properties=newPs}
  where
    newPs = HM.insert property status ps
    ps = properties room

changeRoom :: MonadState GameState m => RoomID -> Room -> m ()
changeRoom roomID newRoom = do
  modify (\GS{rooms, currentRoom} ->
    let newRooms = HM.insert roomID newRoom rooms
     in GS{rooms=newRooms, currentRoom}
    )
