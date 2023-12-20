module Feature.Examine where
import Object.Place (Place)
import Object.Item (Item)
import State.GameState (GameState (currentPlace))
import MapEventHandler.OnExamine (onExaminePlace, onExamineItem)
import Feature.Subplace (subplaceExists)
import Feature.ItemAt (itemAtPlace)
import Feature.Inventory (isInInventory)

canExaminePlace :: Place -> GameState -> Bool
canExaminePlace place state = place == currentPlace state || subplaceExists (currentPlace state) place state

examinePlace :: Place -> GameState -> IO GameState
examinePlace place state = do
    if canExaminePlace place state 
        then onExaminePlace place state
        else do
            putStrLn "You can't examine that place!"
            return state

canExamineItem :: Item -> GameState -> Bool
canExamineItem item state = isInInventory item state || itemAtPlace item (currentPlace state) state

examineItem :: Item -> GameState -> IO GameState
examineItem item state = 
    if canExamineItem item state
        then onExamineItem item state
        else do
            putStrLn "You can't examine that item!"
            return state