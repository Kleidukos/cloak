module Types.Action
  ( Action (..)
  , ActionID (..)
  , ActionError (..)
  ) where

data ActionError = NoAction
  deriving (Show)

newtype ActionID = ActionID Int
  deriving newtype (Show, Eq, Hashable, Ord, Num, Read)

newtype Action = Action Text
  deriving newtype (Show, Eq, IsString)
