module State.GameState where

import Object.Item (Item (Handcuffs, ScrewdriverBit, ScrewdriverHandle))
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
        Handcuffs
    ]
    , currentPlace = MainRoom
    , paths = [
        (MainRoom, Desk),
        (Office, CoffeTable),
        (Office, Cupboard),
        (Office, Computer),
        (Corridor, KeyCase),
        (Corridor, DisplayCase),
        (Corridor, MainRoomEntrance)
        ]
    , unlockedSubplaces = Map.fromList [
        (MainRoom, [HeavyDoor]),
        (Corridor, [BarricadedDoor, ExitDoor]),
        (KeyCase, [Pad10Digit]),
        (Office, [AtticEntrance, CorridorDoor]),
        (Bed, [SitOntoBed]),
        (WoodenBox, [ColorCode])
        ]
    , spawnedItems = Map.empty
    , alarmRings = True
    }
