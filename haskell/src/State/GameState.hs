module State.GameState where

import Object.Item (Item)
import Object.Place (Place (..))
import qualified Data.Map as Map

data GameState = GameState
    { inventory :: [Item]
    , currentPlace :: Place
    , paths :: [(Place, Place)]
    , unlockedSubplaces :: Map.Map Place [Place]
    , spawnedItems :: Map.Map Place [Item]
    } deriving (Show)

initialState :: GameState
initialState = GameState
    { inventory = []
    , currentPlace = MainRoom
    , paths = [
        (MainRoom, Desk),
        (Office, CoffeTable),
        (Office, Cupboard),
        (Office, Computer),
        (Corridor, KeyCase),
        (Corridor, DisplayCase),
        (Corridor, MainRoom),
        (Corridor, MainRoomEntrance)
        ]
    , unlockedSubplaces = Map.fromList [
        (MainRoom, [HeavyDoor]),
        (Corridor, [BarricadedDoor, ExitDoor]),
        (KeyCase, [Pad10Digit]),
        (Office, [AtticEntrance, CorridorDoor]),
        (Bed, [SitOnBed]),
        (WoodenBox, [ColorCode])
        ]
    , spawnedItems = Map.empty
    }
