:- ensure_loaded('../map/paths').
%%%%Rooms
examination(main_room) :-
    write("    Hmmmm... Whoever lived here must have left long ago... 
    I feel a cool breeze coming from a vent located under the celing."),nl.

% examination(corridor) :-
%     write("    Long corrior with paint flaking off the walls due to dense and hiumid air around.
%     It`s connecting the office with the main room where I was trapped before... "),nl.

%%%main_room
examination(desk) :-
    write("    There are few drawers under the desk. I can try to open them.
    ---NEW SUB PLACES UNLOCKED---"),
    assert(subplace(desk, top_drawer)),
    assert(subplace(desk, mid_drawer)),
    assert(subplace(desk, bottom_drawer)),nl.
examination(bottom_drawer) :-
    write("    There is a small bite of cheese. It won't fill my stomach but may come in handy later.
    ---ITEM FOUND---"),
    assert(pickable_item_at(cheese, desk)),nl. % TODO place cheese here
examination(fire_place) :-
    write("    Fire place wasnt used in a long time but thera are still some chared but sturdy pices of wood.
    LONG STICK always can come in handy.
    ---ITEM FOUND---"), % TODO place item here
    assert(pickable_item_at(long_stick, fire_place)),nl. % TODO place cheese here
examination(painting) :-
    write("    It's very dameged. Oh! The TORN CORNER of the painting is peeling back from the frame!
    ---NEW PATH UNLOCKED---"),
    assert(path(painting, torn_corner)),nl.
examination(torn_corner) :-
    write("    After pulling the canvas back I realised that there is a message scratched into painting backing.
    It says:\"I have 4 legs, two heads, huge slender body and little friend.\""),nl. % TODO clue behind painting
examination(chair) :-
    write("    Mud smeared on top looks like a foot print... Why someone was standing on top of it?
    Oh! I can move it underneeth the vent I've seen before
    ---NEW PATH UNLOCKED---"),
    assert(path(chair, vent_cover)),nl.
examination(vent_cover) :-
    write("    It seems that one of the scews is missing. I may be able to loosen rest of them if I had the right tool..."),nl.
examination(wooden_box) :-
    write("     This wooden box looks pretty rough, although it might be impossible to open it by force. But there is some kind of mechanism"),nl,
    assert(item_at(color_code, wooden_box)).
examination(color_code) :-
    write("     Quite bizzare contraption. There are 4 button which all are different color - red, green, blue and yellow.
    Maybe I have to press them in some order?"),nl,
    write("     To enter code use do like so - enter_code(blueYellowGreenRed)"),nl.
examination(heavy_door) :-
    write("    I can't open them! They must be locked from the outside..."),nl.
examination(sit_on_bed) :-
    write("    Hello little buddy. I've found a TEDDY BEAR hidden under the GREEN duvet
    ---ITEM FOUND---"), % TODO place item here
    assert(pickable_item_at(teddy_bear, sit_on_bed)),nl. % TODO place cheese here
examination(bed) :-
    write("    There's a bed with disgustingly YELLOW legs. Your eyes are pulled to two CRIMSON blood-like pillows.
    However quilt seems to be quite different, it calmes you down adn reminds of life outside."),nl.
examination(teddy_bear) :-
    write("    It's lifeless button eyes in pair with his dyed-out BLUE body create dull entirety, which dampens you down"),nl.
examination(window) :-
    write("    RAVEN is beeg and doesn't seem to be scared by me at all. /*He just vibin*/
    Maybe if I had something to push him away I could acces his nest.
    Thermometer shows that there is 40 degrees below 0, it must be broken. Right?"),nl.

%%%%%%%%%%%%%%office
examination(office) :-
    write("    Man this place is devastated. Walls with holes punched into them, blinds ripped off the window.
    I can see an trapdoor under the ceeling. I can't reach it...
    ---PATH UNLOCKED---"),
    assert(path(office, attic_entrance)),nl.
examination(coffee_table) :-
    write("    I found a CORRIDOR KEY taped underneath the table.
    ---ITEM FOUND---"),
    assert(pickable_item_at(corridor_key, coffee_table)),nl.

examination(computer) :-
    %withoutHardDrive(computer),
    write("    It's turned off and will stay that way... I can see that few parts were ripped out of it's case. 
    I won't boot without a HARD DRIVE"),!,nl.

examination(computer) :-
    %turnedOff(computer),
    write("    It's turned off but you are hopeful it'll turn on now, but the on button is too small for my fingers.
    You need to use something to press it.
    ---NEW PATH---"),!,nl.

examination(computer) :-
    %blockedWithPassword(computer),
    write("    The computer is on, but there's a code promt, what's the code?"),nl.

examination(computer) :-
    %lock_opened(computer),
    write("    You managed to log in!
    On the screen there are 4 numbers - "),
    write(computerCode).

examination(left_compartment) :-
    write("    User manual about assembling PC's. May be usefull"),
    assert(pickable_item_at(assembly_manual, cupboard)),nl.
examination(right_compartment) :-
    write("    Old journal covered with leather burried in useless junk at the botom of the compartment."),
    assert(subplace(cupboard, journal)),nl.
examination(journal) :-
    write("    Leather is worn and pages turned yellow over time.
    You can see that only first three pages are filled.").
% TODO: right the journal mechanic
% assert(path(journal, page_1)),
% assert(path(journal, page_2)),
% assert(path(journal, page_3)),nl.
% on_arrival(page_1) :-
%     write("         Date: October 13, 2006
%     Darkness crawls through the corridors of my mind like a swarm of malevolent insects. 
%     The whispers persist, ceaseless and haunting, echoing in the hollow chambers of my fractured sanity.
%     Shadows dance with perverse delight, casting grotesque silhouettes upon the walls of my soul.
%     I am tethered to the precipice of madness,
%     teetering on the edge of a yawning abyss that beckons me into the depths of my own depravity."),nl.
% on_arrival(page_2) :-
%     write("         Date: October 14, 2006
%     The walls, they watch me with eyes unseen, judging my every thought and action.
%     The air is thick with the stench of decay, as if the very fabric of reality is unraveling.
%     I hear the scratching, the scraping, the insidious skittering of unseen vermin that gnaw at the edges of my consciousness.
%     Whispers become screams, and the laughter, oh, the laughter that echoes through the desolate corridors of my tortured mind."),nl.
% on_arrival(page_3) :-
%     write("         dAT: oCToB 8 000
%     In the mirror, I see a visage contorted by the twisted hands of my own derangement.
%     Hollow eyes reflect the void within, a void that hungers for the forbidden knowledge that courses through the veins of the universe.
%     The boundaries between dream and waking nightmare blur into a grotesque tapestry of torment.
%     I have become a vessel for the eldritch forces that seep through the fissures of reality,
%     a conduit for the unspeakable horrors that claw at the fragile membrane of sanity.

%     I am lost in the labyrinth of my own delusions,
%     a madman condemned to dance upon the razor's edge between the realms of the living and the damned.
%     This journal, my only confidante in `this descent into madness,
%     bears witness to the unraveling of a mind consumed by the"),nl.
% on_arrival(page_4) :-
%     write("     darkness that lurks in the hidden recesses of the soul.
%     Within the desolate corridors of my tortured mind, a cryptic mantra emerges: 'WhispersOfTheAbyss'.
%     It guards the forbidden knowledge, a digital key to the eldritch realms that pulse beneath the surface of our reality"),nl.

examination(attic_entrance) :-
    write("    Trapdoor has a T shaped handle. I may be able to hook something on it to pull it open"),nl.
examination(page_3) :-
    write("    It's not finished, 
    /upon futher inspection you found a torn out page placed back at the end of a journal/
    ---PATH UNLOCKED---"),
    assert(path(page_3, page_4)),nl.

examination(_) :-
    write("    Nothing to be seen here..."),nl.


examination(_) :-
    write("    There is nothing usefull to be found..."),nl.

