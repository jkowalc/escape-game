module State.GameState where

import Object.Item (Item (..))
import Object.Place (Place (..))
import qualified Data.Map as Map
import Object.Lock (LockState (LockState))

data GameState = GameState
    { inventory :: [Item]
    , currentPlace :: Place
    , paths :: [(Place, Place)]
    , unlockedSubplaces :: Map.Map Place [Place]
    , spawnedItems :: Map.Map Place [Item]
    , alarmRings :: Bool
    , lockStates :: [LockState]    
    }

initialState :: GameState
initialState = GameState
    { inventory = [
        Handcuffs, Screwdriver, SmallKey
    ]
    , currentPlace = CoffeTable
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
        (Bed, [SitOntoBed]),
        (WoodenBox, [ColorCode]),
        (Cupboard, [LeftCompartment, MiddleCompartment, RightCompartment]),
        (Computer, [ComputerPassword])
        ]
    , spawnedItems = Map.empty
    , alarmRings = True
    , lockStates = 
    [LockState Pad10Digit False "Placeholder",
    LockState Vault False "Placeholder",
    LockState ComputerPassword False "Placeholder",
    LockState ColorCode False "Placeholder"]
    }
