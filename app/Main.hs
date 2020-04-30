module Main (main) where

import           System.IO (BufferMode (..), hSetBuffering)

import           Entities
import           Functions
import           Types

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  putTextLn banner
  putTextLn startMessage
  loop
  where
    loop = evalStateT doStuff startingWorld

doStuff :: (MonadIO m, MonadState GameState m) => m ()
doStuff = do
  mapM_ putTextLn =<< listActions
  choice <- getActionID
  actions <- getActions
  case choiceOf actions choice of
    Left NoAction -> putTextLn "… uh??"
    Right _       -> putTextLn "yeah sure let's do that!"

getActionID ::(MonadIO m) => m ActionID
getActionID = do
  input <- getLine
  case readEither input of
    Left _       -> putTextLn "say what?" >> getActionID
    Right choice -> pure $ choice

banner :: Text
banner = "┌────────────────────────────────────────────────┐\n│ The Cloak of Darkness — An Interactive Fiction │\n│ –— Implemented by Hécate, 2020                 │\n└────────────────────────────────────────────────┘"

startMessage :: Text
startMessage = "You are in the Opera foyer. This is where the game begins. What do you want to do?"
