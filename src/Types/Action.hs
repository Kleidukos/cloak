module Types.Action
  ( Action (..)
  , ActionID (..)
  , ActionError (..)
  ) where

data ActionError = NoAction
  deriving (Show)

newtype ActionID = ActionID Int
  deriving newtype (Show, Eq, Hashable, Ord, Num, Read)

data Action a = Go a
            | Examine a
            | HookCloak
            | Inventory
            deriving (Show, Eq)
