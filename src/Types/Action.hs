module Types.Action
  ( Action (..)
  , ActionID (..)
  ) where

newtype ActionID = ActionID Text
  deriving newtype (Show, Eq)

data Action = Action { name     :: Text
                     , actionID :: ActionID
                     }

