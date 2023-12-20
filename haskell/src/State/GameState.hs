module State.GameState where

import Object.Item (Item, LockState)
import Object.Place (Place (MainRoom))

data GameState = GameState
    { inventory :: [Item]
    , currentPlace :: Place
    , lockStates :: (LockState, LockState, LockState, LockState)    
    } deriving (Show)

initialState :: GameState
initialState = GameState
    { inventory = []
    , currentPlace = MainRoom
    }
