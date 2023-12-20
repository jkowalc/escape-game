module Feature.Use where

import State.GameState (GameState(..), currentPlace)
import Object.Item (Item)
import Object.Place (Place)
import MapEventHandler.OnUse (onUseItem, onUsePlace, usableItemsPlace, usableItemsItem)
import Feature.Inventory (isInInventory)
import Feature.Subplace (subplaceExists)

useOnPlace :: Item -> Place -> GameState -> IO GameState
useOnPlace item place state = 
    if item `elem` usableItemsPlace place && (subplaceExists (currentPlace state) place state || place == currentPlace state) && isInInventory item state
        then onUsePlace item place state
        else do
            putStrLn "You can't use that item on that place!"
            return state

useOnItem :: Item -> Item -> GameState -> IO GameState
useOnItem item1 item2 state =
    if item1 `elem` usableItemsItem item2 && isInInventory item1 state && isInInventory item2 state then
        onUseItem item1 item2 state
    else do
            putStrLn "You can't use that item on that item!"
            return state