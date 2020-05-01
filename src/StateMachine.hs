module StateMachine
  ( module StateMachine
  ) where

-- > runFSM [Examine, Goto (Cloakroom cloakroomDesc), Examine, HookCloak, Goto (Bar ""), Examine, ReadMessage]

import           Control.Monad (foldM)
import qualified Data.Text     as T
import           Prelude       hiding (State, state)

runFSM :: Foldable f => f Event -> IO State
runFSM events = foldM (\state event -> transition event state) startState events

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


transition :: Event -> State -> IO State
transition (Goto destRoom) state = changeRoom state destRoom
transition Examine         state = putTextLn (desc $ room state) >> pure state
transition Inventory       state = checkInventory state
transition HookCloak       state = hookCloak state
transition ReadMessage     state = readMessage state

changeRoom :: State-> Room -> IO State
changeRoom state@State{bar} destRoom =
  case destRoom of
    Foyer _ -> pure state{room=Foyer foyerDesc}
    Bar   _ -> if bar == Unlit
               then pure $ state{room=Bar unlitBarDesc}
               else pure $ state{room=Bar barDesc}
    Cloakroom _ -> pure state{room=Cloakroom cloakroomDesc}

checkInventory :: State -> IO State
checkInventory state@State{..} =
  case inventory of
    Cloak -> putTextLn cloakDesc >> pure state
    Empty -> putTextLn "Nothing" >> pure state

hookCloak :: State -> IO State
hookCloak state@State{room} =
  case room of
    Cloakroom _ -> pure state{inventory=Empty, bar=Lit}
    _           -> pure state

readMessage :: State -> IO State
readMessage state@State{room, bar} =
  case (room, bar) of
    (Bar _, Lit) -> putTextLn "The game is finished!" >> pure state{gameFinished=True}
    _            -> pure state
