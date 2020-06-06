{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NamedFieldPuns   #-}
{-# LANGUAGE RecordWildCards  #-}

module StateMachine
  ( module StateMachine
  ) where

import qualified Data.Text as T
import           Prelude   hiding (State, state)

foyerDesc :: Text
foyerDesc = T.concat [ "The foyer of the opera house. The southern door leads to the bar"
                   , "The Western door leads to the cloakroom"]

unlitBarDesc :: Text
unlitBarDesc = T.concat [ "The bar of the opera house. Completely unlit." ]

barDesc :: Text
barDesc = T.concat [ "The bar of the opera house. The light is on now…" ]

cloakroomDesc :: Text
cloakroomDesc = T.concat [ "The cloakroom." ]

cloakDesc :: Text
cloakDesc = "A mysterious cloak that seems to absord light…"

data Room = Foyer { desc :: Text }
          | Bar { desc :: Text }
          | Cloakroom { desc :: Text }
          deriving (Show, Eq)

data BarState = Lit | Unlit deriving (Show, Eq)

data Inventory = Cloak | Empty deriving (Show, Eq)

data State = State{ room         :: Room
                  , bar          :: BarState
                  , inventory    :: Inventory
                  , dark         :: Int
                  , gameFinished :: Bool
                  } deriving (Eq, Show)

startState :: State
startState = State{ room      = Foyer foyerDesc
                  , bar       = Unlit
                  , inventory = Cloak
                  , dark      = 0
                  , gameFinished = False
                  }

data Event = Goto Room
           | Examine
           | Inventory
           | HookCloak
           | ReadMessage

transition :: (MonadState State m, MonadIO m) => Event -> m ()
transition (Goto destRoom) = changeRoom destRoom
transition Examine         = gets room >>= putTextLn . desc
transition Inventory       = checkInventory
transition HookCloak       = hookCloak
transition ReadMessage     = readMessage

changeRoom :: (MonadState State m) => Room -> m ()
changeRoom destRoom = do
  State{..} <- get
  case destRoom of
    Foyer _ -> modify $ \s -> s{room=Foyer foyerDesc}
    Bar   _ -> if bar == Unlit
               then modify $ \s -> s{room=Bar unlitBarDesc}
               else modify $ \s -> s{room=Bar barDesc}
    Cloakroom _ -> modify (\s -> s{room=Cloakroom cloakroomDesc})

checkInventory :: (MonadState State m, MonadIO m) => m ()
checkInventory = do
  inventory <- gets inventory
  case inventory of
    Cloak -> putTextLn cloakDesc
    Empty -> putTextLn "Nothing"

hookCloak :: (MonadState State m) => m ()
hookCloak = do
  room <- gets room
  case room of
    Cloakroom _ -> modify' (\s -> s{inventory=Empty, bar=Lit})
    _           -> pure ()

readMessage :: (MonadState State m, MonadIO m) => m ()
readMessage = do
  State{room, bar} <- get
  case (room, bar) of
    (Bar _, Lit) -> putTextLn "The game is finished!" >> (modify' (\s -> s{gameFinished=True}))
    _            -> pure ()
