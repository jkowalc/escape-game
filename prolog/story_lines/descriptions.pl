:- ensure_loaded([
    '../map/paths',
    '../rules/moving',
    '../rules/inventory'
]).
% :- discontiguous path/2.

%%%main_room
desctiption(main_room) :-
    write("    I'm in a small dark room. It' full of creepy energy all around...
    Surroundig is dirty and the room is very cold...").
desctiption(desk) :-
    write("    An old desk covered with dust. 
    The chair was mooved to the other end of a room, so I can't sit here...").
desctiption(fire_place) :-
    write("    It's and big antique fireplace.
    I wish it was lit so I could warm myself up. 
    Unfortunetly without matches even the half bured CANDLE sitting on top will be no use for me...").
desctiption(painting) :-
    write("    It's a mastepice I've seen in history books.
    It is beatifull, at least it was... before someone dameged it").
desctiption(torn_corner) :-
    write("    It's a torn corner of a painting. 
    Fabric is deattached from glded wooden frame.").
desctiption(chair) :-
    write("    Old chair lined with red fabric. 
    Looks comfy apart of clay mud wiped all over it...").
desctiption(vent_cover) :-
    write("    This vent cover looks big enouth for me to go inside...").
desctiption(heavy_door) :-
    write("    Big heavy door closed shut.
    Nail marks and scratches don't make me feel good about it...").
desctiption(bed) :-
    write("    In diferent situation, I would love to take a nap. Bed looks komfy, especially with that big PILLOW.
    I guess I can take a sit for a while to think...
    ---ITEM FOUND---"),
    assert(item_at(pillow,bed)).
desctiption(sit_on_bed) :-
    write("    The bed is sqeeqing and the blanket is itchy.
    But it feels good to rest for a second.").
desctiption(window) :-
    write("    Dirty window looking out over moody forest. 
    Thermometer is hanging on the other side.
    On a window still sits a RAVEN in his NEST.
    I don't feel like opening a window with him (or her) on the other side.").
desctiption(bottom_drawer) :-
    write("    There is a small bite of cheese. It won't fill my stomach but may come in handy later.
    ---ITEM FOUND---"),
    assert(item_at(cheese, bottom_drawer)). % TODO place cheese here
desctiption(nest) :-
    write("    Now with the bird gone I can see silver SCREWDRIVER BIT burried in the nest.
    ---ITEM FOUND---"),
    assert(item_at(screwdriver_bit, nest)).

%%%%%%%%%%%%%%%%%%%%%%%%office
desctiption(office) :-
    write("    I'm standing in a middle of poorly lit, destroyed office room.
    Not many things are where they supposed to be. I feel like somebody must have pluderd it long time ago...").
desctiption(coffee_table) :-
    write("    I don't feel right about that coffee table. It's wiped clean of dust comared to the rest of the room.").
desctiption(computer) :-
    write("    Old PC. It's turned off. I hope it's OS was made in this centry...").
desctiption(attic_entrance) :-
    write("    Old trapdoor. I can't reach it in any way possible...").
desctiption(cupboard) :-
    write("    Wide cupboard. It's rotting away abaut to fall appart.
    It has 3 compartments. I'should check if there is something usefull in there.
    ---PATH UNLOCKED---"),
    assert(path(cupboard, left_compartment)),
    assert(path(cupboard, midle_compartment)),
    assert(path(cupboard, right_compartment)).%has journal.
desctiption(left_compartment) :-
    write("    User manual about assembling PC's. May be usefull"),
    assert(item_at(assembly_manual, left_compartment)).
desctiption(right_compartment) :-
    write("    Old journal covered with leather burried in useless junk at the botom of the compartment."),
    assert(path(right_compartment, journal)).
desctiption(journal) :-
    write("    Leather is worn and pages turned yellow over time.
    You can see that only first three pages are filled."),
    assert(path(journal, page_1)).
    assert(path(journal, page_2)).
    assert(path(journal, page_3)).
    
desctiption(page_1) :-
    write("         Date: October 13, 2006
    Darkness crawls through the corridors of my mind like a swarm of malevolent insects. 
    The whispers persist, ceaseless and haunting, echoing in the hollow chambers of my fractured sanity.
    Shadows dance with perverse delight, casting grotesque silhouettes upon the walls of my soul.
    I am tethered to the precipice of madness,
    teetering on the edge of a yawning abyss that beckons me into the depths of my own depravity.").
desctiption(page_2) :-
    write("         Date: October 14, 2006
    The walls, they watch me with eyes unseen, judging my every thought and action.
    The air is thick with the stench of decay, as if the very fabric of reality is unraveling.
    I hear the scratching, the scraping, the insidious skittering of unseen vermin that gnaw at the edges of my consciousness.
    Whispers become screams, and the laughter, oh, the laughter that echoes through the desolate corridors of my tortured mind.").
desctiption(page_3) :-
    write("         dAT: oCToB 8 000
    In the mirror, I see a visage contorted by the twisted hands of my own derangement.
    Hollow eyes reflect the void within, a void that hungers for the forbidden knowledge that courses through the veins of the universe.
    The boundaries between dream and waking nightmare blur into a grotesque tapestry of torment.
    I have become a vessel for the eldritch forces that seep through the fissures of reality,
    a conduit for the unspeakable horrors that claw at the fragile membrane of sanity.

    I am lost in the labyrinth of my own delusions,
    a madman condemned to dance upon the razor's edge between the realms of the living and the damned.
    This journal, my only confidante in `this descent into madness,
    bears witness to the unraveling of a mind consumed by the").
desctiption(page_4) :-
    write("     darkness that lurks in the hidden recesses of the soul.
    Within the desolate corridors of my tortured mind, a cryptic mantra emerges: 'WhispersOfTheAbyss'.
    It guards the forbidden knowledge, a digital key to the eldritch realms that pulse beneath the surface of our reality").

desctiption(office_safe) :-
    write("    Small but sturdy. Too havy to lift. 
    It opens by unlocking a turning code mechanism").

%%%%%%%%%%%corridor
desctiption(corridor) :-
    write("    Long corrior with paint flaking off the walls due to dense and hiumid air around.
    It`s connecting the office with the main room where I was trapped before... ").
desctiption(dispaly_case) :-
    write("    Glass display case, there is a UV flashlight inside
    ---ITEM UNLOCKED---"),
    assert(item_at(uv_flashlight,dispaly_case)).
desctiption(key_case) :-
    write("    Locked key box. Big beautifull key is stored inside. 
    It has to be opened by inputing a code on a keypad").
desctiption(pad_10_digit) :-
    write("    10 digit keypad that will open key case when the code is right. There are 5 empty spots where code will apperar.
        [_ _ _ _ _]").
desctiption(main_room_entrance) :-
    write("     I'm on the other side of that heavy door. I can unlock it now and go back to main room
    ---PATH UNLOCKED---"),
    assert(path(corridor, main_room)),
    retract(path(main_room, heavy_door)),
    go(corridor),
    retract(path(corridor,main_room_entrance)).

desctiption(exit_door) :-
    write("    It's my way out. I just need a key to open it.").


describe :- 
    current_pos(CurrentPlace),
    desctiption(CurrentPlace),
    !, nl.

