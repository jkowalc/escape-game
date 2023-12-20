module Object.Place where

data Place = MainRoom
    | MainRoomEntrance
    | HeavyDoor
    | WoodenBox
    | ColorCode
    | Desk
    | TopDrawer
    | MiddleDrawer
    | BottomDrawer
    | Fireplace
    | Painting
    | TornCorner
    | Chair
    | Vent
    | Rat
    | VentCover
    | Bed
    | SitOntoBed
    | Window
    | Nest
    | Raven
    | Outside
    | Office
    | CorridorDoor
    | AtticEntrance
    | CoffeTable
    | Computer
    | Cupboard
    | LeftCompartment
    | MiddleCompartment
    | RightCompartment
    | Journal
    | Page1
    | Page2
    | Page3
    | Page4
    | OfficeSafe
    | Corridor
    | Vault
    | ExitDoor
    | BarricadedDoor
    | DisplayCase
    | KeyCase
    | Pad10Digit
    | TheEnd
    deriving (Show, Eq, Ord)


-- if user shouldn't be able to enter any of these places, remove them from readsPrec
instance Read Place where
    readsPrec _ "main room" = [(MainRoom, "")]
    readsPrec _ "heavy door" = [(HeavyDoor, "")]
    readsPrec _ "wooden box" = [(WoodenBox, "")]
    readsPrec _ "color code" = [(ColorCode, "")]
    readsPrec _ "desk" = [(Desk, "")]
    readsPrec _ "top drawer" = [(TopDrawer, "")]
    readsPrec _ "middle drawer" = [(MiddleDrawer, "")]
    readsPrec _ "bottom drawer" = [(BottomDrawer, "")]
    readsPrec _ "fireplace" = [(Fireplace, "")]
    readsPrec _ "painting" = [(Painting, "")]
    readsPrec _ "torn corner" = [(TornCorner, "")]
    readsPrec _ "chair" = [(Chair, "")]
    readsPrec _ "vent" = [(Vent, "")]
    readsPrec _ "vent cover" = [(VentCover, "")]
    readsPrec _ "bed" = [(Bed, "")]
    readsPrec _ "sit onto bed" = [(SitOntoBed, "")]
    readsPrec _ "window" = [(Window, "")]
    readsPrec _ "nest" = [(Nest, "")]
    readsPrec _ "raven" = [(Raven, "")]
    readsPrec _ "outside" = [(Outside, "")]
    readsPrec _ "office" = [(Office, "")]
    readsPrec _ "corridor door" = [(CorridorDoor, "")]
    readsPrec _ "attic entrance" = [(AtticEntrance, "")]
    readsPrec _ "coffe table" = [(CoffeTable, "")]
    readsPrec _ "computer" = [(Computer, "")]
    readsPrec _ "cupboard" = [(Cupboard, "")]
    readsPrec _ "left compartment" = [(LeftCompartment, "")]
    readsPrec _ "middle compartment" = [(MiddleCompartment, "")]
    readsPrec _ "right compartment" = [(RightCompartment, "")]
    readsPrec _ "journal" = [(Journal, "")]
    readsPrec _ "page 1" = [(Page1, "")]
    readsPrec _ "page 2" = [(Page2, "")]
    readsPrec _ "page 3" = [(Page3, "")]
    readsPrec _ "page 4" = [(Page4, "")]
    readsPrec _ "office safe" = [(OfficeSafe, "")]
    readsPrec _ "corridor" = [(Corridor, "")]
    readsPrec _ "exit door" = [(ExitDoor, "")]
    readsPrec _ "barricaded door" = [(BarricadedDoor, "")]
    readsPrec _ "display case" = [(DisplayCase, "")]
    readsPrec _ "key case" = [(KeyCase, "")]
    readsPrec _ "pad 10 digit" = [(Pad10Digit, "")]
    readsPrec _ "the end" = [(TheEnd, "")]
    readsPrec _ _ = []