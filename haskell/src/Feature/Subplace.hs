module Feature.Subplace where
import State.GameState (GameState (..))
import Object.Place (Place)
import qualified Data.Map as Map


spawnSubplace :: Place -> Place -> GameState -> IO GameState
spawnSubplace place subplace state
  | subplaceExists place subplace state = do
      putStrLn "Nothing else to be found here"
      return state
  | otherwise = do
      putStrLn "You have discovered a new subplace!"
      return $ state { unlockedSubplaces = Map.insertWith (++) place [subplace] (unlockedSubplaces state) }


despawnSubplace :: Place -> Place -> GameState -> GameState
despawnSubplace place subplace state = state { unlockedSubplaces = Map.adjust (filter (/= subplace)) place (unlockedSubplaces state) }

subplaceExists :: Place -> Place -> GameState -> Bool
subplaceExists place subplace state = subplace `elem` Map.findWithDefault [] place (unlockedSubplaces state)

possibleSubplaces :: Place -> GameState -> [Place]
possibleSubplaces place state = Map.findWithDefault [] place (unlockedSubplaces state)