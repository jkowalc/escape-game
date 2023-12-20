module MapEventHandler.OnArrival where

import Object.Place (Place)
import State.GameState (GameState)

onArrival :: Place -> GameState -> IO GameState
onArrival _ state = do
    putStrLn "You have arrived at a new place!"
    return state