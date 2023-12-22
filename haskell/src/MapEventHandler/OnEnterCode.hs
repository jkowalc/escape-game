{-# LANGUAGE BlockArguments #-}
module MapEventHandler.OnEnterCode where

import State.GameState (GameState(lockStates), LockState(lockPassword))
import Feature.ItemAt (spawnItem)
import Feature.Subplace (despawnSubplace)
import Object.Item (Item(..))
import Object.Place (Place(..))
import Util.IO (printLines)
import State.Util (getLockState)

locks :: [Place]
locks = [Pad10Digit, Vault, ComputerPassword, ColorCode]

onOpenLock:: Place -> GameState -> IO GameState
onOpenLock Pad10Digit state = do
    putStrLn "opened KeyCase"
    let state1 = despawnSubplace KeyCase Pad10Digit state
    spawnItem ExitKey KeyCase state1

onOpenLock Vault state = do
    putStrLn "opened Vault"
    state2 <- spawnItem CorridorKey CoffeTable state
    let state1 = despawnSubplace CoffeTable Vault state2
    return state1

onOpenLock ComputerPassword state = do
    putStrLn "Logged into computer!\n\
    \VAULT CODE: "
    printLines [lockPassword (getLockState Vault state)]
    return state

onOpenLock ColorCode state = do
    putStrLn "opened ColorCode"
    let state1 = despawnSubplace WoodenBox ColorCode state
    spawnItem ScrewdriverHandle WoodenBox state1

onOpenLock _ state = do

    putStrLn "opened other"
    return state

