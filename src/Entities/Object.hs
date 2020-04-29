module Entities.Object
  ( brassHook

  ) where

import           Types.Object

brassHook :: Object
brassHook = Object { name = "Brass hook"
                   , description = "A brass hook… Looks like you can use it."
                   , objectId = ObjectID 1
                   }
