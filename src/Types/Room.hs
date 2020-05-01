module Types.Room
  ( Room (..)
  , RoomID (..)
  , Property (..)
  , Status (..)
  ) where

import           Data.Vector  (Vector)

import           Types.Action
import           Types.Object

newtype RoomID = RoomID Int
  deriving newtype (Show, Eq, Hashable, Read)

data Property = Lit
              | Cloak
  deriving (Show, Eq, Generic, Hashable)

data Status = On
            | Off
            | Hooked
  deriving (Show, Eq)

data Room = Room { name        :: Text
                 , description :: Text
                 , roomID      :: RoomID
                 , north       :: Maybe RoomID
                 , east        :: Maybe RoomID
                 , west        :: Maybe RoomID
                 , south       :: Maybe RoomID
                 , objects     :: Vector Object
                 , actions     :: HashMap ActionID (Action RoomID)
                 , properties  :: HashMap Property Status
                 } deriving (Show, Eq)
