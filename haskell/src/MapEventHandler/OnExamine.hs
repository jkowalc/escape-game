module MapEventHandler.OnExamine where
import Object.Place

import State.GameState (GameState)

onExamine :: Place -> GameState -> IO GameState

onExamine MainRoom state = do 
    putStrLn "Hmmmm... Whoever lived here must have left long ago... \
\I feel a cool breeze coming from a vent located under the celing."
    return state

onExamine Desk state = do 
    putStrLn "There are few drawers under the desk. I can try to open them."
    return state
--     spawn_subplace(desk, top_drawer), / TODO
--     spawn_subplace(desk, mid_drawer),
--     spawn_subplace(desk, bottom_drawer),nl,!.
-- onExamine BottomDrawer = do putStrLn "There is a small bite of cheese. It won't fill my stomach but may come in handy later."
-- --     spawn_item(cheese, desk)"
-- onExamine TopDrawer = do putStrLn "There is a small key. It might fit to something I have right now."
-- --     spawn_item(small_key, desk),nl,!.
onExamine Fireplace state = do 
    putStrLn "Fire place wasnt used in a long time but thera are still some chared but sturdy pices of wood.\
\LONG STICK always can come in handy."
    return state
--     spawn_item(long_stick, fireplace).
onExamine Painting state = do 
    putStrLn "It's very damaged. Oh! The TORN CORNER of the painting is peeling back from the frame!"
    return state
--     spawn_subplace(painting, torn_corner),nl.
onExamine TornCorner state = do 
    putStrLn "After pulling the canvas back I realised that there is a message scratched into painting backing.\
\It says:\"I have 4 legs, two heads, huge slender body and little friend.\""
    return state

onExamine HeavyDoor state = do 
    putStrLn "Big heavy door closed shut.\
\Nail marks and scratches don't make me feel good about it..."
    return state

onExamine Chair state = do 
    putStrLn "Mud smeared on top looks like a foot print... Why someone was standing on top of it?\
\Oh! I can move it underneeth the vent I've seen before."
    return state
--     spawn_subplace(chair, vent_cover).
onExamine WoodenBox state = do 
    putStrLn "This wooden box looks pretty rough, although it might be impossible to open it by force. But there is some kind of mechanism"
    return state

onExamine Bed state = do 
    putStrLn "There's a bed with disgustingly YELLOW legs. Your eyes are pulled to two CRIMSON blood-like pillows.\
\ owever quilt seems to be quite different, it calms you down and reminds of life outside"
    return state

--Office
onExamine Office state = do 
    putStrLn "Man this place is devastated. Walls with holes punched into them, blinds ripped off the window.\
\I can see an trapdoor under the ceeling. I can't reach it..."
    return state



onExamine _ state = do 
    putStrLn "I can't examine it"  -- Default case when none of the patterns match
    return state


-- examination(office) :-
--     write("    Man this place is devastated. Walls with holes punched into them, blinds ripped off the window.
--     I can see an trapdoor under the ceeling. I can't reach it...
--     ---PATH UNLOCKED---"),
--     assert(path(office, attic_entrance)),nl.

-- :- dynamic blockedWithPassword/1, turnedOff/1, withoutHardDrive/1, alarm_rings/0.  
-- examination(vent_cover) :-
--     write("    This vent cover looks big enouth for me to go inside... 
--     It seems that one of the scews is missing. I may be able to loosen rest of them if I had the right tool..."),nl.
-- examination(color_code) :-
--     write("     Quite bizzare contraption. There are 4 button which all are different color - red, green, blue and yellow.
--     Maybe I have to press them in some order?"),nl,
--     write("     To enter code use - eg.: enter_code(blue_yellow_green_red)"),nl.
-- examination(heavy_door) :-
--     write("    I can't open them! They must be locked from the outside..."),nl.
-- examination(sit_on_bed) :-
--     write("    Hello little buddy. I've found a TEDDY BEAR hidden under the GREEN duvet"), nl, 
--     spawn_item(teddy_bear, sit_on_bed).
-- examination(bed) :-
--     write("    ."),nl.
-- examination(teddy_bear) :-
--     write("    It's lifeless button eyes in pair with his dyed-out BLUE body create dull entirety, which dampens you down"),nl.
-- examination(raven) :-
--     write("    RAVEN doesn't seem to be scared by me at all. /*He just vibin*/
--     Maybe if I had something to push him away I could acces his nest.
--     Thermometer shows that there is 40 degrees below 0, it must be broken. Right?"),nl.
-- examination(nest) :-
--     write("    Now with the bird gone I can see silver SCREWDRIVER BIT burried in the nest."),
--     spawn_item(screwdriver_bit, window),nl.
-- %%%main_room
-- examination(desk) :-
--     alarm_rings,
--     retract(alarm_rings),
--     assert(path(main_room, heavy_door)),
--     assert(path(main_room, bed)),
--     assert(path(bed, sit_on_bed)),
--     assert(path(main_room, painting)),
--     assert(path(main_room, window)),
--     assert(path(window, nest)),
--     assert(path(window, outside)),
--     assert(path(main_room, fireplace)),
--     assert(path(main_room, chair)),
--     assert(path(main_room, wooden_box)),

--     write("     I decided to hit the clock as hard as I could. It worked! The clock shattered to pieces.
--     Now there is silence in the room. I can onExamine the desk once more. Maybe I can find here something else."),
--     !,nl.


-- %%%%%%%%%%%%%%office
-- examination(coffee_table) :-
--     write("    Entire table is used by a huge vault"), nl,
--     assert(subplace(coffee_table, vault)).

-- examination(vault) :-
--     write("     There is a padlock to enter the code, I wonder what's the code?"),!,nl.

-- examination(computer) :-
--     withoutHardDrive(computer),
--     write("    It's turned off and will stay that way... I can see that few parts were ripped out of it's case. 
--     I won't boot without a HARD DRIVE"),!,nl.

-- examination(computer) :-
--     turnedOff(computer),
--     write("    It's turned off but I hope it'll turn on now, but the on button is too small for my fingers.
--     I need to use something to press it."),!,nl.

-- examination(computer) :-
--     blockedWithPassword(computer),
--     write("    The computer is on, but there's a password prompt, what can it be?"),!,nl.

-- examination(computer) :-
--     lock_opened(computer),
--     write("    I managed to log in!
--     On the screen there are 5 numbers - "),
--     trueCode(vault, X),
--     write(X),!,nl.

-- examination(left_compartment) :-
--     write("    User manual about assembling PC's. May be usefull"), nl,
--     spawn_item(assembly_manual, cupboard).
-- examination(right_compartment) :-
--     write("    Old journal covered with leather burried in useless junk at the botom of the compartment.
--         ---NEW PATH UNLOCKED---"),
--     assert(path(cupboard, journal)),nl. %%journal work as in minecraft
-- examination(journal) :-
--     write("    Leather is worn and pages turned yellow over time.
--     You can see that only first three pages are filled."),
--     spawn_subplace(journal, page_1),
--     spawn_subplace(journal, page_2),
--     spawn_subplace(journal, page_3),nl.


-- %%%%journal
-- examination(page_1) :-
--     write("         Date: October 13, 2006
--     Darkness crawls through the corridors of my mind like a swarm of malevolent insects. 
--     The whispers persist, ceaseless and haunting, echoing in the hollow chambers of my fractured sanity.
--     Shadows dance with perverse delight, casting grotesque silhouettes upon the walls of my soul.
--     I am tethered to the precipice of madness,
--     teetering on the edge of a yawning abyss that beckons me into the depths of my own depravity."),nl.
-- examination(page_2) :-
--     write("         Date: October 14, 2006
--     The walls, they watch me with eyes unseen, judging my every thought and action.
--     The air is thick with the stench of decay, as if the very fabric of reality is unraveling.
--     I hear the scratching, the scraping, the insidious skittering of unseen vermin that gnaw at the edges of my consciousness.
--     Whispers become screams, and the laughter, oh, the laughter that echoes through the desolate corridors of my tortured mind."),nl.
-- examination(page_3) :-
--     write("         dAT: oCToB 8 000
--     In the mirror, I see a visage contorted by the twisted hands of my own derangement.
--     Hollow eyes reflect the void within, a void that hungers for the forbidden knowledge that courses through the veins of the universe.
--     The boundaries between dream and waking nightmare blur into a grotesque tapestry of torment.
--     I have become a vessel for the eldritch forces that seep through the fissures of reality,
--     a conduit for the unspeakable horrors that claw at the fragile membrane of sanity.

--     I am lost in the labyrinth of my own delusions,
--     a madman condemned to dance upon the razor's edge between the realms of the living and the damned.
--     This journal, my only confidante in `this descent into madness,
--     bears witness to the unraveling of a mind consumed by the..."),nl,
--     write("    /It's not finished, upon futher inspection you found a torn out page placed back at the end of a journal/"),
--     spawn_subplace(journal, page_4),nl.
-- examination(page_4) :-
--     write("     darkness that lurks in the hidden recesses of the soul.
--     Within the desolate corridors of my tortured mind, a cryptic mantra emerges: 'whispers_of_the_abyss'.
--     It guards the forbidden knowledge, a digital key to the eldritch realms that pulse beneath the surface of our reality"),nl.

-- examination(attic_entrance) :-
--     write("    Trapdoor has a T shaped handle. I barely cannot reach it. I may be able to hook something on it to pull it open"),nl.


-- examination(baricated_door) :-
--     write("     I'm on the other side of that heavy door. It's blocked with rumble. I can unlock it now and go back to main room
--     ---PATH UNLOCKED---"),nl,
--     assert(path(corridor, main_room)),
--     retract(subplace(main_room, heavy_door)),
--     retract(subplace(corridor,baricated_door)).

-- %%%corridor
-- examination(corridor) :-
--     write("    Long corridor with paint flaking off the walls due to dense and humid air around.
--      It's connecting the office with the main room where I was trapped before... "),nl.

-- examination(pad_10_digit) :-
--     write("    10 digit keypad that will open key case when the code is right. There are 5 empty spots where code will apperar.
--         [_ _ _ _ _]"),nl.

-- examination(display_case) :-
--     write("    Inside I can see an weird flashlight, it might help me. I should start using it on some objects"),nl,
--     spawn_item(uv_flashlight, display_case),nl,!.

-- examination(key_case) :-
--     write("    It's a key case! It has 10 digit padcase. May it contain the key to the exit?"),nl,
--     assert(subplace(pad_10_digit, key_case)),nl,!.  % TODO: CHANGE


-- examination(_) :-
--     write("    There is nothing usefull to be found..."),nl.


-- %%%uv light
-- lightable_by_uv(painting).
-- lightable_by_uv(bed).
-- lightable_by_uv(computer).
-- lightable_by_uv(desk).
-- lightable_by_uv(fireplace).
-- lightable_by_uv(window).

-- examination(painting) :-
--     holding(uv_flashlight),
--     write("     I can see some words written in UV ink.
--     \"after I wake up  I always eat my cheese, then breath in some fresh air. Later I play some computer games, after that I heat myself up.\""),nl,!.

-- examination(bed) :-
--     holding(uv_flashlight),
--     write("     I can see something is written here in UV ink - number 2"),nl,!.

-- examination(desk) :-
--     holding(uv_flashlight),
--     write("     I can see something is written here in UV ink - number 1"),nl,!.

-- examination(window) :-
--     holding(uv_flashlight),
--     write("     I can see something is written here - number 0"),nl,!.

-- examination(computer) :-
--     holding(uv_flashlight),
--     turnedOff(computer),
--     write("     I can see something is written here - number 3"),nl,!.

-- examination(computer) :-
--     holding(uv_flashlight),
--     write("     I can see something is written here - but I cannot read it. I need to turnoff the computer."),nl,!.

-- examination(fireplace) :-
--     holding(uv_flashlight),
--     write("     I can see something is written here - number 7"),nl,!.