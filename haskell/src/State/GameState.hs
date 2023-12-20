module State.GameState where

import Object.Item (Item (..))
import Object.Place (Place (..))
import qualified Data.Map as Map
import Object.Lock (LockState (LockState))

data ComputerState = ComputerState
    { computerOn :: Bool
    , hardDriveIn :: Bool
    }

data GameState = GameState
    { inventory :: [Item]
    , currentPlace :: Place
    , paths :: [(Place, Place)]
    , unlockedSubplaces :: Map.Map Place [Place]
    , spawnedItems :: Map.Map Place [Item]
    , alarmRings :: Bool
    , lockStates :: [LockState]
    , computerState :: ComputerState
    , randomSeed :: Int    
    }

initialState :: GameState
initialState = GameState
    { inventory = [
        Handcuffs
    ]
    , currentPlace = MainRoom
    , paths = [
        (MainRoom, Desk),
        (Office, CoffeTable),
        (Office, Cupboard),
        (Office, Computer),
        (Corridor, KeyCase)
        ]
    , unlockedSubplaces = Map.fromList [
        (MainRoom, [HeavyDoor]),
        (Corridor, [BarricadedDoor, ExitDoor, DisplayCase]),
        (KeyCase, [Pad10Digit]),
        (Office, [CorridorDoor]),
        (WoodenBox, [ColorCode]),
        (Cupboard, [LeftCompartment, MiddleCompartment, RightCompartment])
        ]
    , spawnedItems = Map.empty
    , alarmRings = True
    , lockStates = 
    [LockState Pad10Digit False "Placeholder",
    LockState Vault False "Placeholder",
    LockState ComputerPassword False "whispers of the abyss",
    LockState ColorCode False "yellow red green blue"]
    , computerState = ComputerState False False
    , randomSeed = 0
    }

setRandomPasswords :: GameState -> Int -> GameState
setRandomPasswords gs seed = do
    let vaultPassword = show seed
    let reverseSeed = 109999 - seed
    let digit0 = (reverseSeed - reverseSeed `mod` 10000) `div` 10000 
    let digit1 = (reverseSeed `mod` 10000 - reverseSeed `mod` 1000) `div` 1000
    let digit2 = (reverseSeed `mod` 1000 - reverseSeed `mod` 100) `div` 100
    let digit3 = (reverseSeed `mod` 100 - reverseSeed `mod` 10) `div` 10
    let digit4 = reverseSeed `mod` 10 `div` 1
    let tendigitPassword = show ((digit3 * 100) + digit4 + (digit2 * 10) + (digit0 * 10000) + (digit1 * 1000))
    let vL = LockState Vault False vaultPassword
    let tenL = LockState Pad10Digit False tendigitPassword
    let lSL = [tenL, vL, lockStates gs !! 2, lockStates gs !! 3]
    gs {lockStates = lSL}
