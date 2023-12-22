module Feature.EnterCode where

import State.GameState (GameState (lockStates, currentPlace), LockState(..))
import Object.Place (Place)
import MapEventHandler.OnEnterCode (onOpenLock, lockNames)
import Util.IO (printLines)
import Data.Maybe (fromMaybe)
import Data.List (elemIndex)
import Feature.Subplace (subplaceExists)

enterCode :: String -> String -> GameState -> IO GameState
enterCode userCode lockName state = do
    print lockName
    let cp = currentPlace state
    let lS = lockStates state
    let maybeLockIndex = elemIndex lockName lockNames
    case maybeLockIndex of
        Nothing -> do
                printLines ["It's not a lock!"]
                return state
        _ -> do
            let lockIndex = fromMaybe (-1) maybeLockIndex
            if checkIfReachable (subPlace (lS !! lockIndex)) state then do
                if not (isOpen (lS !! lockIndex))then do
                    if userCode == lockPassword (lS !! lockIndex) then do
                        printLines ["You managed to open the lock!"]
                        state <- onOpenLock lockIndex state
                        return state
                        -- changeLockState state1 lockIndex True
                    else do
                        printLines ["Wrong password!"]
                        return state
                else do
                    printLines ["Lock is already open!"]
                    return state
            else do
                printLines ["Cannot reach the lock!"]
                return state

changeLockState :: Int -> Bool -> GameState -> GameState
changeLockState lockIndex newValue state = do
    let lS = lockStates state
    let newLockState = LockState
            { subPlace = subPlace (lS !! lockIndex),
            isOpen = newValue,
            lockPassword = lockPassword (lS !! lockIndex)}
    let newlockStates = take lockIndex lS ++ [newLockState] ++ drop (lockIndex + 1) lS
    state { lockStates = newlockStates }


checkIfReachable ::  Place -> GameState -> Bool
checkIfReachable thingToReach state = subplaceExists (currentPlace state) thingToReach state