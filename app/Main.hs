module Main (main) where

import           System.IO (BufferMode (..), hSetBuffering)

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  putTextLn banner
  putTextLn startMessage
  pure ()

-- doStuff :: (MonadIO m, MonadState GameState m) => m ()
-- doStuff = do
  -- mapM_ putTextLn =<< listActions
  -- choice <- getActionID
  -- actions <- getActions
  -- case choiceOf actions choice of
  --   Left NoAction -> putTextLn "… uh??"
  --   Right _       -> putTextLn "yeah sure let's do that!"

banner :: Text
banner = "┌────────────────────────────────────────────────┐\n│ The Cloak of Darkness — An Interactive Fiction │\n│ –— Implemented by Hécate, 2020                 │\n└────────────────────────────────────────────────┘"

startMessage :: Text
startMessage = "You are in the Opera foyer. This is where the game begins. What do you want to do?"
