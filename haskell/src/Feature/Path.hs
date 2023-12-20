module Feature.Path where
import State.GameState (GameState (paths))
import Object.Place (Place)
import qualified Data.Set as Set


spawnPath :: (Place, Place) -> GameState -> IO GameState
spawnPath path state = 
    if path `elem` paths state || (snd path, fst path) `elem` paths state
        then return state
        else do
            putStrLn "You have discovered a new path!"
            return state { paths = path : paths state }

despawnPath :: (Place, Place) -> GameState -> GameState
despawnPath path state = 
    state { paths = filter (filterPath path) (paths state) }
    where
        filterPath :: (Place, Place) -> (Place, Place) -> Bool
        filterPath path1 path2 = path2 /= path1 && path2 /= (snd path1, fst path1)

pathExists :: (Place, Place) -> GameState -> Bool
pathExists path state = path `elem` paths state || (snd path, fst path) `elem` paths state

possibleDestinations :: Place -> GameState -> Set.Set Place
possibleDestinations place state = Set.fromList (map snd (filter (\(x, y) -> x == place) (paths state)) ++ map fst (filter (\(x, y) -> y == place) (paths state)))
