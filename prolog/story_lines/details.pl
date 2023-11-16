:- ensure_loaded('../map/paths').
%%%%Rooms
examine(main_room) :-
    write("    Hmmmm... Whoever lived here must have left long ago... 
    I feel a cool breeze coming from a vent located under the celing.").
% examine(office) :-
%     write("    I'm standing in a middle of poorly lit, destroyed office room.
%     Not many things are where they supposed to be. I feel like somebody must have pluderd it long time ago...").
% examine(corridor) :-
%     write("    Long corrior with paint flaking off the walls due to dense and hiumid air around.
%     It`s connecting the office with the main room where I was trapped before... ").
%%%main_room
examine(desk) :-
    write("    There are few drawers under the desk. I can try to open them.
    ---NEW PATH UNLOCKED---"),
    assert(path(desk, top_drawer)),
    assert(path(desk, mid_drawer)),
    assert(path(desk, bottom_drawer)).
examine(fire_place) :-
    write("    Fire place wasnt used in a long time but thera are still some chared but sturdy pices of wood.
    LONG STICK always can come in handy.
    ---ITEMS FOUND---").
examine(painting) :-
    write("    It's very dameged. Oh! The TORN CORNER of the painting is peeling back from the frame!
    ---NEW PATH UNLOCKED---"),
    assert(path(painting, torn_corner)).
examine(torn_corner) :-
    write("    After pulling the canvas back I realised that there is a message scratched into painting backing.
    It says:-------------CLUE CLUE CLUE CLUE CLUE CLUE CLUE-------------"). % TODO clue behind painting
examine(chair) :-
    write("    Mud smeared on top looks like a foot print... Why someone was standing on top of it?
    Oh! I can move it underneeth the vent I've seen before
    ---NEW PATH UNLOCKED---"),
    assert(path(chair, vent_cover)).
examine(vent_cover) :-
    write("    It seems that one of the scews is missing. I may be able to loosen rest of them if I had the right tool...").
examine(vent_cover) :-
    write("    This vent cover looks big enouth for me to go inside...").
examine(heavy_door) :-
    write("    Big heavy door closed shut.
    Nail marks and scratches don't make me feel good about it...").
examine(bed) :-
    write("    In diferent situation, I would love to take a nap. Bed looks komfy, especially with that big PILLOW.
    I guess I can take a sit for a while to think...").

examine(_) :-
    write("    Nothing to be seen here...").

examine(_) :-
    write("    Nothing to be seen here...").

examine(_) :-
    write("    Nothing to be seen here...").

examine(_) :-
    write("    Nothing to be seen here...").

examine(_) :-
    write("    Nothing to be seen here...").

examine(_) :-
    write("    Nothing to be seen here...").


examine(_) :-
    write("    There is nothing usefull to be found...").


inspect :- 
    current_pos(CurrentPlace),
    examine(CurrentPlace),
    !, nl.

