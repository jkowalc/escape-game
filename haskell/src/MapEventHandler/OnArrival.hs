module MapEventHandler.OnArrival where

import Object.Place (Place (..))
import Object.Item (Item (..))
import State.GameState (GameState (alarmRings))
import Feature.Subplace (spawnSubplace, despawnSubplace)
import Feature.ItemAt (spawnItem)
import Feature.Path (spawnPath, despawnPath)
import Feature.Look (printPossibilities)

onArrival :: Place -> GameState -> IO GameState

onArrival MainRoom state = do
    if alarmRings state then do
        putStrLn "\tI'm in a small dark room. I'm handcuffed! I don't remember anything. Surrounding is dirty and the room is very cold...\n\
        \\tAn alarm clock is ringing very loudly and is exploding my head. I have to go to the desk and examine it.\n\
        \\tMaybe I can disable the alarm."
        return state
    else do
        putStrLn "\tI'm in a small dark room. It' full of creepy energy all around...\n\
        \\tSurrounding is dirty and the room is very cold..."
        return state

onArrival Desk state = do
    if alarmRings state then do
        putStrLn "\tThere's the alarm. I have to examine the desk, maybe I can disable the alarm."
        return state
    else do
        putStrLn "\tAn old desk covered with dust.\n\
        \\tThe chair was moved to the other end of a room, so I can't sit here..."
        return state

onArrival Fireplace state = do
    putStrLn "\tIt's and big antique fireplace.\n\
    \\tI wish it was lit so I could warm myself up.\n\
    \\tUnfortunately without matches even the half burned CANDLE sitting on top will be no use for me..."
    return state

onArrival Painting state = do
    putStrLn "\tIt's a masterpiece. I've seen it in history books.\n\
    \\tIt is beautiful, at least it was... before someone damaged it"
    return state

onArrival TornCorner state = do
    putStrLn "\tIt's a torn corner of a painting.\n\
    \\tFabric is detached from the gilded wooden frame."
    return state

onArrival Chair state = do
    putStrLn "\tOld chair lined with red fabric.\n\
    \\tLooks comfy apart from the clay mud wiped all over it..."
    return state

onArrival Vent state = do
    putStrLn "\tThere is a RAT in here!"
    spawnSubplace Vent Rat state

onArrival Bed state = do
    putStrLn "\tIn at different situation, I would love to take a nap. Bed looks comfy, especially with that big PILLOW.\n\
    \\tI guess I can take a sit for a while to think..."
    newState <- spawnItem Pillow Bed state
    putStrLn "\tThe bed is squeaky and the blanket is itchy.\n\
    \\tBut it feels good to rest for a second."
    return newState

onArrival Window state = do
    putStrLn "\tDirty window looking out over moody forest.\n\
    \\tThermometer is hanging on the other side.\n\
    \\tOn a window still sits a RAVEN in his NEST.\n\
    \\tI don't feel like opening a window with him (or her) on the other side."
    spawnSubplace Window Raven state

-- office

onArrival Office state = do
    putStrLn "\tI'm standing in a middle of poorly lit, destroyed office room.\n\
    \\tNot many things are where they supposed to be. I feel like somebody must have plundered it long time ago..."
    return state

onArrival CoffeTable state = do
    putStrLn "\tI don't feel right about that coffee table. It's wiped clean of dust compared to the rest of the room."
    return state

onArrival Computer state = do
    putStrLn "\tOld PC. It's turned off. I hope it's OS was made in this century..."
    return state

onArrival AtticEntrance state = do
    putStrLn "\tOld trapdoor. I can't reach it in any way possible..."
    return state

onArrival Cupboard state = do
    putStrLn "\tWide cupboard. It's rotting away about to fall apart.\n\
    \\tIt has 3 compartments. I'should check if there is something useful in there."
    return state

onArrival Journal state = do
    putStrLn "\tI opened an old journal I've found. It's dusty but I still want to find out more about it."
    return state

onArrival OfficeSafe state = do
    putStrLn "\tSmall but sturdy. Too heavy to lift.\n\
    \\tIt opens by unlocking a turning code mechanism"
    return state

-- corridor

onArrival Corridor state = do
    putStrLn "\tLong corridor with paint flaking off the walls due to dense and humid air around.\n\
    \\tIt`s connecting the office with the main room where I was trapped before... "
    return state

onArrival DisplayCase state = do
    putStrLn "\tGlass display case, there is something inside"
    return state

onArrival KeyCase state = do
    putStrLn "\tLocked key box. Big beautiful key is stored inside.\n\
    \\tIt has to be opened by inputting a code on a keypad"
    return state

onArrival BarricadedDoor state = do
    putStrLn "\tI'm on the other side of that heavy door. It's blocked with rumble. I can unlock it now and go back to main room"
    state1 <- spawnPath (Corridor, MainRoom) state
    let state2 =  despawnSubplace MainRoom HeavyDoor state1
    let state3 = despawnSubplace Corridor BarricadedDoor state2
    printPossibilities state3
    return state3

onArrival ExitDoor state = do
    putStrLn "\tIt's my way out. I just need a key to open it."
    return state

onArrival TheEnd state = do
    putStrLn "\tCONGRATULATIONS YOU COMPLETED THE GAME!"
    return $ despawnPath (Corridor, TheEnd) state

onArrival _ state = do
    putStrLn "You have arrived at a new place!"
    return state