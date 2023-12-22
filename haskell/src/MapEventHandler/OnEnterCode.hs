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

onOpenLock:: GameState -> Int -> IO GameState
onOpenLock state 0 = do
    putStrLn "opened KeyCase"
    let state1 = despawnSubplace KeyCase Pad10Digit state
    spawnItem ExitKey KeyCase state1

onOpenLock state 1 = do
    putStrLn "opened Vault"
    state2 <- spawnItem CorridorKey CoffeTable state
    let state1 = despawnSubplace CoffeTable Vault state2
    return state1

onOpenLock state 2 = do
    putStrLn "Logged into computer!\n\
    \VAULT CODE: "
    printLines [lockPassword (lockStates state !! 1)]
    return state
onOpenLock state 3 = do
    putStrLn "opened ColorCode"
    let state1 = despawnSubplace WoodenBox ColorCode state
    spawnItem ScrewdriverHandle WoodenBox state1
onOpenLock state _ = do
    putStrLn "opened other"
    return state

