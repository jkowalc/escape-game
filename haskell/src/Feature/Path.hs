module Feature.Path where
import State.GameState (GameState (paths))
import Object.Place (Place)


spawnPath :: (Place, Place) -> GameState -> IO GameState
spawnPath path state = 
    if path `elem` paths state || (snd path, fst path) `elem` paths state
        then return state
        else do
            putStrLn "You have discovered a new path!"
            return state { paths = path : paths state }

pathExists :: (Place, Place) -> GameState -> Bool
pathExists path state = path `elem` paths state || (snd path, fst path) `elem` paths state