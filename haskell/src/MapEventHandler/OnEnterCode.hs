{-# LANGUAGE BlockArguments #-}
module MapEventHandler.OnEnterCode where
import Data.Bool
import Data.List (elemIndex)
import Data.Maybe (fromMaybe)
import Util.IO (printLines)
import Object.Place (Place)
import Object.Lock (LockState(..), lockNames)
import State.GameState (GameState (lockStates, currentPlace, inventory, GameState))
import Core.Command (Command(Inventory))

enterCode :: GameState -> String -> String -> IO GameState
enterCode gs lockName user_code = do
    let cp = currentPlace gs
    let lS = lockStates gs
    let maybeLockIndex = elemIndex lockName lockNames
    case maybeLockIndex of
        Nothing -> do
                printLines ["It's not a lock!"]
                return gs
        _ -> do
            let lockIndex = fromMaybe (-1) maybeLockIndex
            if checkIfReachable gs lockName then do
                if not (isOpen (lS !! lockIndex))then do
                    if user_code == lockPassword(lS !! lockIndex) then do
                        printLines ["You managed to open the lock!"]
                        let newGameState = changeLockState gs lockIndex True
                        return newGameState
                    else do
                        printLines ["Wrong password!"]
                        return gs
                else do
                    printLines ["Lock is already open!"]
                    return gs
            else do
                printLines ["Cannot reach the lock!"]
                return gs

changeLockState :: GameState -> Int -> Bool -> GameState
changeLockState gs lockIndex newValue = do
    let cp = currentPlace gs
    let inv = inventory gs
    let lS = lockStates gs
    let newLockState = LockState 
            { name = name (lS !! lockIndex),
            isOpen = newValue,
            lockPassword = lockPassword(lS !! lockIndex)}
    let newlockStates = take lockIndex lS ++ [newLockState] ++ drop (lockIndex + 1) lS
    GameState {inventory = inv, currentPlace = cp, lockStates = newlockStates}


checkIfReachable :: GameState -> String -> Bool
checkIfReachable gs thingToReach = True