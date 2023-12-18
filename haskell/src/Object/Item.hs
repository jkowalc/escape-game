module Object.Item where


data Item = UVFlashlight
    | LongStick
    | Cheese
    | Screwdriver
    | HardDrive
    | Feather
    | SmallKey
    | ExitKey
    | OpenHandcuffs
    | CorridorKey
    | ScrewdriverHandle
    | ScrewdriverBit
    | TeddyBear
    | AssemblyManual
    | Pillow
    deriving (Show, Eq)


-- if user shouldn't be able to enter any of these items, remove them from readsPrec
instance Read Item where
    readsPrec _ "uv flashlight" = [(UVFlashlight, "")]
    readsPrec _ "long stick" = [(LongStick, "")]
    readsPrec _ "cheese" = [(Cheese, "")]
    readsPrec _ "screwdriver" = [(Screwdriver, "")]
    readsPrec _ "hard drive" = [(HardDrive, "")]
    readsPrec _ "feather" = [(Feather, "")]
    readsPrec _ "small key" = [(SmallKey, "")]
    readsPrec _ "exit key" = [(ExitKey, "")]
    readsPrec _ "open handcuffs" = [(OpenHandcuffs, "")]
    readsPrec _ "corridor key" = [(CorridorKey, "")]
    readsPrec _ "screwdriver handle" = [(ScrewdriverHandle, "")]
    readsPrec _ "screwdriver bit" = [(ScrewdriverBit, "")]
    readsPrec _ "teddy bear" = [(TeddyBear, "")]
    readsPrec _ "assembly manual" = [(AssemblyManual, "")]
    readsPrec _ "pillow" = [(Pillow, "")]
    readsPrec _ _ = []
