module Types.Object
  ( Object (..)
  , ObjectID (..)
  ) where

newtype ObjectID = ObjectID Text
  deriving newtype (Show, Eq)

data Object = Object { name        :: Text
                     , description :: Text
                     , objectId    :: ObjectID
                     } deriving (Show)
