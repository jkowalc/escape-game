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
        putStrLn "\tI'm in a small dark room. I'm handcuffed! I don't remeber anything. Surroundig is dirty and the room is very cold...\n\
        \\tAn alarm clock is ringing very loudly and is exploading my head. I have to go to the desk and examine it.\n\
        \\tMaybe I can disable the alarm."
        return state
    else do
        putStrLn "\tI'm in a small dark room. It' full of creepy energy all around...\n\
        \\tSurroundig is dirty and the room is very cold..."
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
    \\tUnfortunetly without matches even the half bured CANDLE sitting on top will be no use for me..."
    return state

onArrival Painting state = do
    putStrLn "\tIt's a mastepice. I've seen it in history books.\n\
    \\tIt is beatifull, at least it was... before someone damaged it"
    return state

onArrival TornCorner state = do
    putStrLn "\tIt's a torn corner of a painting.\n\
    \\tFabric is deattached from glded wooden frame."
    return state

onArrival Chair state = do
    putStrLn "\tOld chair lined with red fabric.\n\
    \\tLooks comfy apart of clay mud wiped all over it..."
    return state

onArrival Vent state = do
    putStrLn "\tThere is a RAT in here!"
    spawnSubplace Vent Rat state

onArrival Bed state = do
    putStrLn "\tIn diferent situation, I would love to take a nap. Bed looks komfy, especially with that big PILLOW.\n\
    \\tI guess I can take a sit for a while to think..."
    newState <- spawnItem Pillow Bed state
    putStrLn "\tThe bed is sqeeqing and the blanket is itchy.\n\
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
    \\tNot many things are where they supposed to be. I feel like somebody must have pluderd it long time ago..."
    return state

onArrival CoffeTable state = do
    putStrLn "\tI don't feel right about that coffee table. It's wiped clean of dust comared to the rest of the room."
    return state

onArrival Computer state = do
    putStrLn "\tOld PC. It's turned off. I hope it's OS was made in this centry..."
    return state

onArrival AtticEntrance state = do
    putStrLn "\tOld trapdoor. I can't reach it in any way possible..."
    return state

onArrival Cupboard state = do
    putStrLn "\tWide cupboard. It's rotting away abaut to fall appart.\n\
    \\tIt has 3 compartments. I'should check if there is something usefull in there."
    state1 <- spawnSubplace Cupboard LeftCompartment state
    state2 <- spawnSubplace Cupboard MiddleCompartment state1
    spawnSubplace Cupboard RightCompartment state2

onArrival Journal state = do
    putStrLn "\tI opened an old journal I've found. It's dusty but I still want to find out more about it."
    return state

onArrival OfficeSafe state = do
    putStrLn "\tSmall but sturdy. Too havy to lift.\n\
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
    putStrLn "\tLocked key box. Big beautifull key is stored inside.\n\
    \\tIt has to be opened by inputing a code on a keypad"
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