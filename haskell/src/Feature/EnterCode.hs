module Feature.EnterCode where

import State.GameState (GameState (lockStates, currentPlace), LockState(..))
import Object.Place (Place)
import MapEventHandler.OnEnterCode (onOpenLock, lockNames)
import Util.IO (printLines)
import Data.Maybe (fromMaybe)
import Data.List (elemIndex)
import Feature.Subplace (subplaceExists)

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
checkIfReachable gs thingToReach = subplaceExists (currentPlace gs) thingToReach gs