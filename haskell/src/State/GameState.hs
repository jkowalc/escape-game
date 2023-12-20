module State.GameState where

import Object.Item (Item)
import Object.Place (Place (MainRoom))
import Object.Lock (LockState (LockState))

data GameState = GameState
    { inventory :: [Item]
    , currentPlace :: Place
    , lockStates :: [LockState]    
    }

initialState :: GameState
initialState = GameState
    { inventory = []
    , currentPlace = MainRoom
    , lockStates = 
    [LockState "10PadDigit" False "Placeholder",
    LockState "Vault" False "Placeholder",
    LockState "Computer" False "Placeholder",
    LockState "ColorCode" False "Placeholder"]
    }
