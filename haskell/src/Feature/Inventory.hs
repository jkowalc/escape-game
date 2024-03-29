module Feature.Inventory where
import Object.Item (Item)
import State.GameState (GameState (inventory, currentPlace, GameState))
import Feature.ItemAt (removeItemFromPlace, addItemToPlace, itemAtPlace)
import Util.IO (printLines, formatThing)

isInInventory :: Item -> GameState -> Bool
isInInventory item state = item `elem` inventory state

printInventory :: GameState -> IO ()
printInventory state = do
    let items = inventory state
    if null items
        then putStrLn "You have no items!"
        else do
            putStrLn "You have the following items:"
            printLines (map formatThing items)

removeItemFromInventory :: Item -> GameState -> GameState
removeItemFromInventory item state = 
    if isInInventory item state
        then state { inventory = filter (/= item) (inventory state) }
        else state

addItemToInventory :: Item -> GameState -> GameState
addItemToInventory item state = 
    if isInInventory item state
        then state
        else state { inventory = item : inventory state }

takeItem :: Item -> GameState -> IO GameState
takeItem item state
    | isInInventory item state = do
        putStrLn "You already have this item!"
        return state
    | not (itemAtPlace item (currentPlace state) state) = do
        putStrLn "There is no such item here!"
        return state
    | otherwise = do
        putStrLn "You have taken the item!"
        return $ addItemToInventory item (removeItemFromPlace item (currentPlace state) state)
    
dropItem :: Item -> GameState -> IO GameState
dropItem item state
    | not (isInInventory item state) = do
        putStrLn "You don't have this item!"
        return state
    | otherwise = do
        putStrLn "You have dropped the item!"
        return $ removeItemFromInventory item (addItemToPlace item (currentPlace state) state)