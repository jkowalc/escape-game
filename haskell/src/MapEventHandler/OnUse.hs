module MapEventHandler.OnUse where

import Object.Place (Place (..))
import Object.Item (Item (..))
import State.GameState (GameState (computerState), ComputerState(..))
import Feature.Examine (examinePlace)
import Feature.Subplace (despawnSubplace, spawnSubplace)
import Feature.Look (printPossibilities)
import Feature.Inventory (removeItemFromInventory, addItemToInventory, isInInventory)
import Feature.Path (spawnPath)
import Feature.ItemAt (spawnItem)

usableItemsPlace :: Place -> [Item]
usableItemsPlace place = case place of
    Painting -> [UVFlashlight]
    Bed -> [UVFlashlight]
    Computer -> [HardDrive, Feather, UVFlashlight]
    Desk -> [UVFlashlight]
    Fireplace -> [UVFlashlight]
    Raven -> [LongStick]
    Rat -> [Cheese]
    VentCover -> [Screwdriver]
    ExitDoor -> [ExitKey]
    AtticEntrance -> [OpenHandcuffs]
    CorridorDoor -> [CorridorKey]
    _ -> []

usableItemsItem :: Item -> [Item]
usableItemsItem item = case item of
    Handcuffs -> [SmallKey]
    _ -> []

lightableByUV :: Place -> Bool
lightableByUV place = place `elem` [Painting, Bed, Computer, Desk, Fireplace, Window]

onUsePlace :: Item -> Place -> GameState -> IO GameState

onUsePlace UVFlashlight place state = do
    if lightableByUV place then do
        examinePlace place state
    else do
        putStrLn "\tI can't see anything new!"
        return state

onUsePlace LongStick Raven state = do
    putStrLn "\tI've succesfully pushed the RAVEN away. Not only it's now away from his nest, but also he left something behind."
    let state1 = despawnSubplace Window Raven state
    state2 <- spawnSubplace Window Nest state1
    spawnItem Feather Window state

onUsePlace Cheese Rat state = do
    putStrLn "\tI baited the rat outside of the vent. I can crawl across it now."
    spawnPath (Vent, Office) state

onUsePlace Screwdriver VentCover state = do
    putStrLn "\tI menaged to loosen the screws holding the vent cover. Now I can climb up to the vent itself."
    let state1 = despawnSubplace Chair VentCover state
    state2 <- spawnPath (Chair, Vent) state1
    printPossibilities state2
    return state2

onUsePlace HardDrive Computer state = do
    putStrLn "Using HardDrive on computer" -- TODO
    if isInInventory AssemblyManual state then do
        putStrLn "I managed to assebly computer using the manual!"
        let newCS = ComputerState{
            computerOn = computerOn (computerState state),
            hardDriveIn = not (hardDriveIn (computerState state))
        }
        let takeAwayHardDrive = removeItemFromInventory HardDrive state{computerState = newCS}
        return (removeItemFromInventory AssemblyManual takeAwayHardDrive)
    else do
        putStrLn "I don't know how to insert the hard drive to the computer.\n\tIf only there was any manual..."
        return state

onUsePlace Feather Computer state = do
    putStrLn "Using Feather on computer"
    if hardDriveIn (computerState state) then do
        if computerOn (computerState state) then
            putStrLn "I turned off the computer!"
            else putStrLn "I turned on the computer!"
        let newCS = ComputerState{
            computerOn = not (computerOn (computerState state)),
            hardDriveIn = hardDriveIn (computerState state)
        }
        return state{computerState = newCS}
    else do
        putStrLn "I have to fix the computer to turn it on!"
        return state

onUsePlace ExitKey ExitDoor state = do
    putStrLn "I see light! Freedom is mine!"
    let state1 = removeItemFromInventory ExitKey state
    spawnPath (Corridor, TheEnd) state1

onUsePlace OpenHandcuffs AtticEntrance state = do
    putStrLn "\tI managed to open the entrance to attic!\n\
    \\tI still cannot go there, but something has fallen out of it."
    spawnItem HardDrive Office state

onUsePlace CorridorKey CorridorDoor state = do
    putStrLn "\tI managed to open the door leading to the corridor"
    let state1 = despawnSubplace Office CorridorDoor state
    spawnPath (Office, Corridor) state1

onUsePlace _ _ state = do
    putStrLn "You can't use that here!"
    return state
onUseItem :: Item -> Item -> GameState -> IO GameState

onUseItem SmallKey Handcuffs state = do
    putStrLn "\tI managed to open these handcuffs, they may be useful later, so I'll keep them."
    let state1 = removeItemFromInventory SmallKey state
    let state2 = removeItemFromInventory Handcuffs state1
    return $ addItemToInventory OpenHandcuffs state2

onUseItem _ _ state = do
    putStrLn "You can't use that here!"
    return state
