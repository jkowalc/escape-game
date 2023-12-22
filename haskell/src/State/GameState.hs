module State.GameState where

import Object.Item (Item (..))
import Object.Place (Place (..))
import qualified Data.Map as Map

data ComputerState = ComputerState
    { computerOn :: Bool
    , hardDriveIn :: Bool
    }

data LockState = LockState
    {   
        isOpen :: Bool
        ,lockPassword :: String
    }

data GameState = GameState
    { inventory :: [Item]
    , currentPlace :: Place
    , paths :: [(Place, Place)]
    , unlockedSubplaces :: Map.Map Place [Place]
    , spawnedItems :: Map.Map Place [Item]
    , alarmRings :: Bool
    , lockStates :: Map.Map Place LockState
    , computerState :: ComputerState
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
    , lockStates = Map.fromList [
        (Pad10Digit, LockState False "Placeholder"),
        (Vault, LockState False "Placeholder"),
        (ComputerPassword, LockState False "whispers of the abyss"),
        (ColorCode, LockState False "yellow red green blue")
    ]
    , computerState = ComputerState False False
    }