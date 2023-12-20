module State.GameState where

import Object.Item (Item (..))
import Object.Place (Place (..))
import qualified Data.Map as Map

data GameState = GameState
    { inventory :: [Item]
    , currentPlace :: Place
    , paths :: [(Place, Place)]
    , unlockedSubplaces :: Map.Map Place [Place]
    , spawnedItems :: Map.Map Place [Item]
    , alarmRings :: Bool
    } deriving (Show)

initialState :: GameState
initialState = GameState
    { inventory = [
        Handcuffs, Screwdriver, SmallKey, CorridorKey
    ]
    , currentPlace = Office
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
        (Cupboard, [LeftCompartment, MiddleCompartment, RightCompartment])
        ]
    , spawnedItems = Map.empty
    , alarmRings = True
    }
