module State.GameState where

import Object.Item (Item)
import Object.Place (Place (MainRoom))

data GameState = GameState
    { inventory :: [Item]
    , currentPlace :: Place
    } deriving (Show)

initialState :: GameState
initialState = GameState
    { inventory = []
    , currentPlace = MainRoom
    }
