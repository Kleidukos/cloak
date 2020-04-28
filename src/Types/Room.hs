module Types.Room
  ( Room (..)
  , RoomID (..)
  ) where

import           Data.Vector  (Vector)

import           Types.Action
import           Types.Object

newtype RoomID = RoomID Text
  deriving newtype (Show, Eq)


data Room = Room { name        :: Text
                 , description :: Text
                 , roomID      :: RoomID
                 , north       :: Maybe RoomID
                 , east        :: Maybe RoomID
                 , west        :: Maybe RoomID
                 , south       :: Maybe RoomID
                 , objects     :: Vector Object
                 , actions     :: HashMap Text Action
                 }
