module Feature.EnterCode where

import State.GameState (GameState (lockStates, currentPlace), LockState(..))
import Object.Place (Place)
import MapEventHandler.OnEnterCode (onOpenLock, locks)
import Util.IO (printLines)
import Data.Maybe (fromMaybe)
import Data.List (elemIndex)
import Feature.Subplace (subplaceExists)
import qualified Data.Map as Map
import State.Util (getLockState)

isALock :: Place -> Bool
isALock place = place `elem` locks

enterCode :: String -> Place -> GameState -> IO GameState
enterCode userCode place state = do
    if not (isALock place) then do
        printLines ["It's not a lock!"]
        return state
    else do
        let lockState = getLockState place state
        if subplaceExists (currentPlace state) place state then do
            if not (isOpen lockState) then do
                if userCode == lockPassword lockState then do
                    printLines ["You managed to open the lock!"]
                    newState <- onOpenLock place state
                    return $ changeLockState place True newState
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

changeLockState :: Place -> Bool -> GameState -> GameState
changeLockState place newValue state = do
    let lockState = getLockState place state
    state { lockStates = Map.insert place (lockState { isOpen = newValue }) (lockStates state) }


checkIfReachable ::  Place -> GameState -> Bool
checkIfReachable thingToReach state = subplaceExists (currentPlace state) thingToReach state