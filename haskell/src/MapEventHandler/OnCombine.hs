module MapEventHandler.OnCombine where

import State.GameState (GameState (..))
import Object.Item (Item (ScrewdriverBit, ScrewdriverHandle, Screwdriver))
import Feature.Inventory (removeItemFromInventory, addItemToInventory)

canCombine :: Item -> Item -> Bool
canCombine ScrewdriverBit ScrewdriverHandle = True
canCombine ScrewdriverHandle ScrewdriverBit = True
canCombine _ _ = False

onCombine :: Item -> Item -> GameState -> IO GameState
onCombine ScrewdriverBit ScrewdriverHandle state = do
    putStrLn "\tYou have combined the two screwdriver bits into a screwdriver!"
    let state1 = removeItemFromInventory ScrewdriverBit state
    let state2 = removeItemFromInventory ScrewdriverHandle state1
    return $ addItemToInventory Screwdriver state2

onCombine ScrewdriverHandle ScrewdriverBit state =
    onCombine ScrewdriverBit ScrewdriverHandle state

onCombine _ _ state = do
    putStrLn "You can't combine those items!"
    return state