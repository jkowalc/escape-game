{-# LANGUAGE BlockArguments #-}
module MapEventHandler.OnEnterCode where
import Data.Bool
import Data.List (elemIndex)
import Data.Maybe (fromMaybe)
import Util.IO (printLines)
import Object.Place (Place (..))
import Object.Item (Item (..))
import Object.Lock (LockState(..), lockNames)
import State.GameState (GameState (lockStates, currentPlace, inventory, GameState))
import Core.Command (Command(Inventory))
import Feature.Path (pathExists)
import Feature.Subplace (possibleSubplaces)
import Feature.ItemAt (spawnItem)
import Feature.Subplace (spawnSubplace, despawnSubplace)

enterCode :: GameState -> String -> String -> IO GameState
enterCode gs user_code lockName = do
    print lockName
    let cp = currentPlace gs
    let lS = lockStates gs
    let maybeLockIndex = elemIndex lockName lockNames
    case maybeLockIndex of
        Nothing -> do
                printLines ["It's not a lock!"]
                return gs
        _ -> do
            let lockIndex = fromMaybe (-1) maybeLockIndex
            if checkIfReachable gs (subPlace (lS !! lockIndex)) then do
                if not (isOpen (lS !! lockIndex))then do
                    if user_code == lockPassword (lS !! lockIndex) then do
                        printLines ["You managed to open the lock!"]
                        state <- onOpenLock gs lockIndex
                        return state
                        -- changeLockState state1 lockIndex True
                    else do
                        printLines ["Wrong password!"]
                        return gs
                else do
                    printLines ["Lock is already open!"]
                    return gs
            else do
                printLines ["Cannot reach the lock!"]
                return gs


--lockNames = ["Pad10Digit", "Vault", "ComputerPassword", "ColorCode"]


onOpenLock:: GameState -> Int -> IO GameState
onOpenLock state 0 = do
    putStrLn "opened KeyCase"
    let state1 = despawnSubplace KeyCase Pad10Digit state
    spawnItem ExitKey KeyCase state1
    return state

onOpenLock state 1 = do
    putStrLn "opened Vault"
    state2 <- spawnItem CorridorKey CoffeTable state
    let state1 = despawnSubplace CoffeTable Vault state2
    return state1

onOpenLock state 2 = do
    putStrLn "Logged into computer!\n\
    \VAULT CODE: "
    printLines[lockPassword (lockStates state !! 1)]
    return state
onOpenLock state 3 = do
    putStrLn "opened ColorCode"
    let state1 = despawnSubplace WoodenBox ColorCode state
    spawnItem ScrewdriverHandle WoodenBox state1
onOpenLock state 4 = do
    putStrLn "opened ColorCode"
    let state1 = despawnSubplace WoodenBox ColorCode state
    spawnItem ScrewdriverHandle WoodenBox state1
onOpenLock state _ = do
    putStrLn "opened other"
    return state
    


changeLockState :: GameState -> Int -> Bool -> GameState
changeLockState gs lockIndex newValue = do
    let lS = lockStates gs
    let newLockState = LockState
            { subPlace = subPlace (lS !! lockIndex),
            isOpen = newValue,
            lockPassword = lockPassword (lS !! lockIndex)}
    let newlockStates = take lockIndex lS ++ [newLockState] ++ drop (lockIndex + 1) lS
    gs { lockStates = newlockStates }


checkIfReachable :: GameState -> Place -> Bool
checkIfReachable gs thingToReach = thingToReach `elem` possibleSubplaces (currentPlace gs) gs