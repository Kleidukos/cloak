module Types.Object
  ( Object (..)
  , ObjectID (..)
  ) where

newtype ObjectID = ObjectID Int
  deriving newtype (Show, Eq, Hashable)

data Object = Object { name        :: Text
                     , description :: Text
                     , objectId    :: ObjectID
                     } deriving (Show, Eq)
