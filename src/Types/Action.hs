module Types.Action
  ( Action (..)
  , ActionID (..)
  ) where

newtype ActionID = ActionID Int
  deriving newtype (Show, Eq, Hashable)

newtype Action = Action Text
  deriving newtype (Show, Eq, IsString)
