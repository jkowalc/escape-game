module Feature.Combine where

import State.GameState (GameState (..))
import Object.Item (Item)
import Object.Place (Place)
import Feature.Inventory (isInInventory)
import MapEventHandler.OnCombine (onCombine, canCombine)

combine :: Item -> Item -> GameState -> IO GameState

combine item1 item2 state = do
    if canCombine item1 item2 && isInInventory item1 state && isInInventory item2 state
        then onCombine item1 item2 state
        else do
            putStrLn "You can't combine those items!"
            return state