module MapEventHandler.OnEnterCode where
import Data.Bool
import Data.List (elemIndex)

data LockState = LockState
    {   
        isOpen :: Bool
        lockPassword :: String
    }
let LockNames = [10PadDigit, Vault, Computer, ColorCode]

EnterCode :: GameState -> String -> String -> IO GameState

EnterCode gs(inv, cp, lS) lockName user_code = 
    let LockIndex = elemIndex lockName lS
    case LockIndex of
        Nothing -> printLines ""
        _ -> do
            if CheckIfReachable gs lockName == True then do
                if user_code == (lockPassword lS !! LockIndex) then do
                    lS = 
                
        
    else

EnterCode gs(inv, cp, lS) Vault user_code = do
    pass

EnterCode gs(inv, cp, lS) Computer user_code = do
    pass

EnterCode gs(inv, cp, lS) ColorCode user_code = do
    pass    

ChangeLockState :: GameState -> Integer -> Bool -> GameState
ChangeLockState gs(inv, cp , lS) LockIndex newValue = do 
    let newLockState = LockState newValue lockPassword (lS !! LockIndex)
    let newlockStates = take index lS ++ newLockState ++ drop (index + 1) lS
    GameState inv cp newlockStates


CheckIfReachable :: GameState -> String -> Bool
CheckIfReachable gs(inv, cp, lS) thingToReach = True

NameIsALock :: String -> Bool
NameIsALock ln = lockName elem LockNames

CheckIfCorrectCode :: GameState -> String -> String -> Bool
CheckIfCorrectCode gs(inv, cp, ls) lockName userCode = do
    let Lock