module Main (main) where

import           Entities
import           Types

main :: IO ()
main = loop
  where
    loop = evalStateT doStuff startingWorld

doStuff :: MonadState GameState m => m ()
doStuff = do
  startMessage
  listActions


startMessage :: Text
startMessage = "You are in the Opera foyer. This is where the game begins. What do you want to do?"
