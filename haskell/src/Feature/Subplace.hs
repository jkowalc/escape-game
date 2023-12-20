module Feature.Subplace where
import State.GameState (GameState (..))
import Object.Place (Place)
import qualified Data.Map as Map


spawnSubplace :: Place -> Place -> GameState -> IO GameState
spawnSubplace place subplace state = do
    putStrLn "You have discovered a new subplace!"
    return state { unlockedSubplaces = Map.insertWith (++) place [subplace] (unlockedSubplaces state) }

subplaceExists :: Place -> Place -> GameState -> Bool
subplaceExists place subplace state = subplace `elem` Map.findWithDefault [] place (unlockedSubplaces state)