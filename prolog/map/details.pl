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
    ---NEW PATH UNLOCKED---"),
    assert(subplace(desk, top_drawer)),
    assert(subplace(desk, mid_drawer)),
    assert(subplace(desk, bottom_drawer)),nl.
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
    It says:-------------CLUE CLUE CLUE CLUE CLUE CLUE CLUE-------------"),nl. % TODO clue behind painting
examination(chair) :-
    write("    Mud smeared on top looks like a foot print... Why someone was standing on top of it?
    Oh! I can move it underneeth the vent I've seen before
    ---NEW PATH UNLOCKED---"),
    assert(path(chair, vent_cover)),nl.
examination(vent_cover) :-
    write("    It seems that one of the scews is missing. I may be able to loosen rest of them if I had the right tool..."),nl.
examination(heavy_door) :-
    write("    I can't open them! They must be locked from the outside..."),nl.
examination(sit_on_bed) :-
    write("    Hello little buddy. I've found a TEDDY BEAR hidden under the blanket
    ---ITEM FOUND---"), % TODO place item here
    assert(pickable_item_at(teddy_bear, sit_on_bed)),nl. % TODO place cheese here
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
    write("    I found a CORRIDOR KEY taped underneeth the table.
    ---ITEM FOUND---"),
    assert(pickable_item_at(corridor_key, coffee_table)),nl.
examination(computer) :-
    write("    It's turned off and will stay that way... I can see that few parts were ripped out of it's case. 
    I won't boot without a HARD DRIVE"),nl.
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
