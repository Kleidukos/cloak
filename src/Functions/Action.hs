module Functions.Action
  ( choiceOf
  , getActions
  ) where

import qualified Data.HashMap.Strict as HM
import           Data.Maybe          (fromJust)

import           Functions.Room      (getRoom)
import           Types.Action
import           Types.GameState
import           Types.Room          (Room (..))

choiceOf :: HashMap ActionID Action -- ^ The actions of the room
         -> ActionID                -- ^ The selected action (by the user)
         -> Either ActionError Action  -- ^ Either the action does not exist (faulty input)
                                    -- or the action exists and this is its return type
choiceOf actions actionID =
  case HM.lookup actionID actions of
    Just action -> Right action
    Nothing     -> Left NoAction

getActions :: (MonadState GameState m) => m (HashMap ActionID Action)
getActions = do
  currentRoomID <- gets currentRoom
  room <- getRoom currentRoomID
  let acts = actions $ fromJust room
  pure acts
