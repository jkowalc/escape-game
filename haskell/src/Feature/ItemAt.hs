module Feature.ItemAt where

import Object.Item (Item)
import Object.Place (Place)
import State.GameState (GameState (spawnedItems, currentPlace, inventory))
import qualified Data.Map as Map

itemAtPlace :: Item -> Place -> GameState -> Bool
itemAtPlace item place state = item `elem` Map.findWithDefault [] place (spawnedItems state)

itemExists :: Item -> GameState -> Bool
itemExists item state = item `elem` Map.foldr (++) [] (spawnedItems state) || item `elem` inventory state

addItemToPlace :: Item -> Place -> GameState -> GameState
addItemToPlace item place state = 
    if itemAtPlace item place state
        then state
        else state { spawnedItems = Map.insertWith (++) place [item] (spawnedItems state) }

removeItemFromPlace :: Item -> Place -> GameState -> GameState
removeItemFromPlace item place state = 
    if not (itemExists item state)
        then state
        else state { spawnedItems = Map.adjust (filter (/= item)) place (spawnedItems state) }

spawnItem :: Item -> GameState -> IO GameState
spawnItem item state = 
    if itemExists item state
        then return state
        else do
            putStrLn "You have discovered a new item!"
            return state { spawnedItems = Map.insertWith (++) (currentPlace state) [item] (spawnedItems state) }

