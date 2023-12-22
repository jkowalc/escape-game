module MapEventHandler.OnExamine where
import Object.Place (Place (..))
import Object.Item (Item (..))
import State.GameState (GameState (..), ComputerState(computerOn, hardDriveIn), LockState(lockPassword, isOpen))
import Feature.Path (spawnPath)
import Feature.Subplace (spawnSubplace, despawnSubplace)
import Feature.Inventory (isInInventory)
import Feature.ItemAt (spawnItem)
import State.Util (getLockState)

onExaminePlace :: Place -> GameState -> IO GameState

onExaminePlace Corridor state = do
    putStrLn "\tLong corridor with paint flaking off the walls due to dense and humid air around.\n\
    \\tIt's connecting the office with the main room where I was trapped before... "
    return state

onExaminePlace Pad10Digit state = do
    putStrLn "\t10 digit keypad that will open key case when the code is right. There are 5 empty spots where code will appear.\n\
    \\t[ _ _ _ _ _ ]"
    return state

onExaminePlace DisplayCase state = do
    putStrLn "\tInside I can see a weird flash light, it might help me. I should start using it on some objects"
    spawnItem UVFlashlight Corridor state

onExaminePlace KeyCase state = do
    putStrLn "\tIt's a key case! It has 10 digit pad case. May it contain the key to the exit?"
    spawnSubplace Pad10Digit KeyCase state

--MainRoom

onExaminePlace MainRoom state = do
    putStrLn "\tHmmmm... Whoever lived here must have left long ago... \n\
    \\tI feel a cool breeze coming from a vent located under the ceiling."
    return state

onExaminePlace Desk state
    | alarmRings state = do
        putStrLn "\tI decided to hit the clock as hard as I could. It worked! The clock shattered to pieces.\n\
        \\tNow there is silence in the room. I can examine the desk once more. Maybe I can find here something else."
        state2 <- spawnPath (MainRoom, HeavyDoor) state { alarmRings = False }
        state3 <- spawnPath (MainRoom, Bed) state2
        state4 <- spawnPath (Bed, SitOntoBed) state3
        state5 <- spawnPath (MainRoom, Painting) state4
        state8 <- spawnPath (MainRoom, Window) state5
        state9 <- spawnPath (MainRoom, Fireplace) state8
        state10 <- spawnPath (MainRoom, Chair) state9
        spawnPath (MainRoom, WoodenBox) state10
    | isInInventory UVFlashlight state = do
        putStrLn ("\tI can see something is written here in UV ink - number " ++ [lockPassword (getLockState Pad10Digit state) !! 1])
        return state
    | otherwise = do
        putStrLn "\tThere are few drawers under the desk. I can try to open them."
        state1 <- spawnSubplace Desk TopDrawer state
        state2 <- spawnSubplace Desk MiddleDrawer state1
        spawnSubplace Desk BottomDrawer state2

onExaminePlace Window state =
    if isInInventory UVFlashlight state then do
        putStrLn ("\tI can see something is written here in UV ink - number " ++ [lockPassword (getLockState Pad10Digit state) !! 2])
        return state
    else do
        putStrLn "I can't examine it"
        return state

onExaminePlace BottomDrawer state = do
    putStrLn "\tThere is a small bite of cheese. It won't fill my stomach but may come in handy later."
    spawnItem Cheese Desk state

onExaminePlace TopDrawer state = do
    putStrLn "\tThere is a small key. It might fit to something I have right now."
    spawnItem SmallKey Desk state

onExaminePlace Fireplace state = do
    if isInInventory UVFlashlight state then do
        putStrLn ("\tI can see something is written here - number " ++ [lockPassword (getLockState Pad10Digit state) !! 4])
        return state
    else do
        putStrLn "\tFire place wasn't used in a long time but there are still some charred but sturdy pieces of wood.\n\
        \\tLONG STICK always can come in handy."
        spawnItem LongStick Fireplace state

onExaminePlace Painting state =
    if isInInventory UVFlashlight state then do
        putStrLn "\tI can see some words written in UV ink.\n\
        \\tafter I wake up  I always eat my cheese, then breath in some fresh air. Later I play some computer games, after that I heat myself up."
        return state
    else do
        putStrLn "\tIt's very damaged. Oh! The TORN CORNER of the painting is peeling back from the frame!"
        spawnSubplace Painting TornCorner state

onExaminePlace TornCorner state = do
    putStrLn "\tAfter pulling the canvas back I realized that there is a message scratched into painting backing.\n\
    \\tIt says:\"I have 4 legs, two heads, huge slender body and little friend.\""
    return state

onExaminePlace HeavyDoor state = do
    putStrLn "\tBig heavy door closed shut.\n\
    \\tNail marks and scratches don't make me feel good about it..."
    return state

onExaminePlace Chair state = do
    putStrLn "\tMud smeared on top looks like a foot print... Why someone was standing on top of it?\n\
    \\tOh! I can move it underneath the vent I've seen before."
    spawnSubplace Chair VentCover state

onExaminePlace VentCover state = do
    putStrLn "\tThis vent cover looks big enough for me to go inside... \n\
    \\tIt seems that one of the screws is missing. I may be able to loosen rest of them if I had the right tool..."
    return state

onExaminePlace WoodenBox state = do
    putStrLn "\tThis wooden box looks pretty rough, although it might be impossible to open it by force. But there is some kind of mechanism"
    return state

onExaminePlace ColorCode state = do
    putStrLn "\tQuite bizarre contraption. There are 4 buttons which all are different color - red, green, blue and yellow.\n\
    \\tMaybe I have to press them in some order?"
    putStrLn "To enter code use - eg.: enter blue yellow green red into color code"
    return state

onExaminePlace SitOntoBed state = do
    putStrLn "\tHello little buddy. I've found a TEDDY BEAR hidden under the GREEN duvet"
    spawnItem TeddyBear SitOntoBed state

onExaminePlace Bed state = do
    if isInInventory UVFlashlight state then do
        putStrLn ("\tI can see something is written here in UV ink - number " ++ [lockPassword (getLockState Pad10Digit state) !! 0])
        return state
    else do
        putStrLn "\tThere's a bed with disgustingly YELLOW legs. Your eyes are pulled to two CRIMSON blood-like pillows\n\
        \\t however quilt seems to be quite different, it calms you down and reminds of life outside"
        return state

onExaminePlace Raven state = do
    putStrLn "\tRAVEN doesn't seem to be scared by me at all. /*He just vibin'*/\n\
    \\tMaybe if I had something to push him away I could access his nest.\n\
    \\tThermometer shows that there are 40 degrees below 0, it must be broken. Right?"
    return state

onExaminePlace Nest state = do
    putStrLn "\tNow with the bird gone I can see silver SCREWDRIVER BIT buried in the nest."
    spawnItem ScrewdriverBit Window state

--Office
onExaminePlace Office state = do
    putStrLn "\tMan this place is devastated. Walls with holes punched into them, blinds ripped off the window.\n\
    \\tI can see a trapdoor under the ceiling. I can't reach it..."
    spawnSubplace Office AtticEntrance state

onExaminePlace CoffeTable state = do
    putStrLn "\tEntire table is used by a huge vault"
    spawnSubplace CoffeTable Vault state

onExaminePlace Vault state = do
    putStrLn "\tThere is a padlock to enter the code, I wonder what's the code?"
    return state

onExaminePlace Computer state = do
    if isInInventory UVFlashlight state then do
        if not(computerOn (computerState state)) then do
            putStrLn ("\tI can see something is written here in UV ink - number " ++ [lockPassword (getLockState Pad10Digit state) !! 3])
        else
            putStrLn "\tI can see something is written here - but I cannot read it. I need to turnoff the computer. "
        return state
    else do
        if hardDriveIn (computerState state) then do
            if computerOn (computerState state) then do
                if not (isOpen (getLockState ComputerPassword state)) then do
                    let newState = spawnSubplace Computer ComputerPassword state
                    putStrLn "\tThe computer is on, but there's a password prompt, what can it be?"
                else
                    putStrLn ("\tI managed to log in!\n\tOn the screen there are 5 numbers - " ++ lockPassword (getLockState Vault state))
            else
                putStrLn "\tIt's turned off but I hope it'll turn on now, but the on button is too small for my fingers.\n\tI need to use something to press it"
        else
            putStrLn "\tIt's turned off and will stay that way... I can see that a few parts were ripped out of its case.\n\tI won't boot without a HARD DRIVE"
        return state

onExaminePlace ComputerPassword state = do
    putStrLn "\tI can type in a password..." -- TODO
    return state

onExaminePlace LeftCompartment state = do
    putStrLn "\tUser manual about assembling PC's. May be useful"
    spawnItem AssemblyManual Cupboard state

onExaminePlace RightCompartment state = do
    putStrLn "\tOld journal covered with leather buried in useless junk at the bottom of the compartment."
    spawnPath (Cupboard, Journal) state

onExaminePlace Journal state = do
    putStrLn "\tLeather is worn and pages turned yellow over time.\n\
    \\tYou can see that only first three pages are filled."
    state1 <- spawnSubplace Journal Page3 state
    state2 <- spawnSubplace Journal Page2 state1
    spawnSubplace Journal Page1 state2

-- journal

onExaminePlace Page1 state = do
    putStrLn "\tDate: October 13, 2006\n\
    \\tDarkness crawls through the corridors of my mind like a swarm of malevolent insects.\n\
    \\tThe whispers persist, ceaseless and haunting, echoing in the hollow chambers of my fractured sanity.\n\
    \\tShadows dance with perverse delight, casting grotesque silhouettes upon the walls of my soul.\n\
    \\tI am tethered to the precipice of madness,\n\
    \\tteetering on the edge of a yawning abyss that beckons me into the depths of my own depravity."
    return state

onExaminePlace Page2 state = do
    putStrLn "\tDate: October 14, 2006\n\
    \\tThe walls, they watch me with eyes unseen, judging my every thought and action.\n\
    \\tThe air is thick with the stench of decay, as if the very fabric of reality is unravelling.\n\
    \\tI hear the scratching, the scraping, the insidious skittering of unseen vermin that gnaw at the edges of my consciousness.\n\
    \\tWhispers become screams, and the laughter, oh, the laughter that echoes through the desolate corridors of my tortured mind."
    return state

onExaminePlace Page3 state = do
    putStrLn "\tDate: October 8, 000\n\
    \\tIn the mirror, I see a visage contorted by the twisted hands of my own derangement.\n\
    \\tHollow eyes reflect the void within, a void that hungers for the forbidden knowledge that courses through the veins of the universe.\n\
    \\tThe boundaries between dream and waking nightmare blur into a grotesque tapestry of torment.\n\
    \\tI have become a vessel for the eldritch forces that seep through the fissures of reality,\n\
    \\ta conduit for the unspeakable horrors that claw at the fragile membrane of sanity.\n\
    \\tI am lost in the labyrinth of my own delusions,\n\
    \\ta madman condemned to dance upon the razor's edge between the realms of the living and the damned.\n\
    \\tThis journal, my only confidante in `this descent into madness,\n\
    \\tbears witness to the unravelling of a mind consumed by the..."
    spawnSubplace Journal TornOutPage state

onExaminePlace TornOutPage state = do
    putStrLn "\tdarkness that lurks in the hidden recesses of the soul.\n\
    \\tWithin the desolate corridors of my tortured mind, a cryptic mantra emerges: 'whispers of the abyss'.\n\
    \\tIt guards the forbidden knowledge, a digital key to the eldritch realms that pulse beneath the surface of our reality"
    return state
onExaminePlace AtticEntrance state = do
    putStrLn "\tTrapdoor has a T shaped handle. I barely cannot reach it. I may be able to hook something on it to pull it open"
    return state

onExaminePlace CorridorDoor state = do
    putStrLn "\tLocked... I can see a key hole, it may fix the problem"
    return state

onExaminePlace BarricadedDoor state = do
    putStrLn "\tI'm on the other side of that heavy door. It's blocked with rumble. I can unlock it now and go back to main room"
    state1 <- spawnPath (Corridor, MainRoom) state
    return $ despawnSubplace Corridor BarricadedDoor $ despawnSubplace MainRoom HeavyDoor state1

onExaminePlace _ state = do
    putStrLn "I can't examine it"  -- Default case when none of the patterns match
    return state

onExamineItem :: Item -> GameState -> IO GameState
onExamineItem TeddyBear state = do
    putStrLn "It's lifeless button eyes in pair with his dyed-out BLUE body create dull entirety, which dampens you down"
    return state
onExamineItem _ state = do
    putStrLn "I can't examine it"  -- Default case when none of the patterns match
    return state
