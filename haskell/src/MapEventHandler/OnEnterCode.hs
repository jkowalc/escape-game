{-# LANGUAGE BlockArguments #-}
module MapEventHandler.OnEnterCode where

import State.GameState (GameState(lockStates), LockState(lockPassword))
import Feature.ItemAt (spawnItem)
import Feature.Subplace (despawnSubplace)
import Object.Item (Item(..))
import Object.Place (Place(..))
import Util.IO (printLines)

lockNames :: [String]
lockNames = ["Pad10Digit", "Vault", "ComputerPassword", "ColorCode"]

onOpenLock:: Int -> GameState -> IO GameState
onOpenLock 0 state = do
    putStrLn "opened KeyCase"
    let state1 = despawnSubplace KeyCase Pad10Digit state
    spawnItem ExitKey KeyCase state1

onOpenLock 1 state = do
    putStrLn "opened Vault"
    state2 <- spawnItem CorridorKey CoffeTable state
    let state1 = despawnSubplace CoffeTable Vault state2
    return state1

onOpenLock 2 state = do
    putStrLn "Logged into computer!\n\
    \VAULT CODE: "
    printLines [lockPassword (lockStates state !! 1)]
    return state
onOpenLock 3 state = do
    putStrLn "opened ColorCode"
    let state1 = despawnSubplace WoodenBox ColorCode state
    spawnItem ScrewdriverHandle WoodenBox state1
onOpenLock _ state = do
    putStrLn "opened other"
    return state

