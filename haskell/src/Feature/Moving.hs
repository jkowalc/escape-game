module Feature.Moving where
import State.GameState (GameState (currentPlace))
import Object.Place (Place)
import Feature.Path (pathExists)

go :: Place -> GameState -> IO GameState
go place state = do
    if pathExists (currentPlace state, place) state
        then return state { currentPlace = place }
        else do
            putStrLn "You can't go there!"
            return state