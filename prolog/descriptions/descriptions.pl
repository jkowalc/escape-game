:- ensure_loaded('../map/paths').
%%%%Rooms
desctiption(main_room) :-
    write("    I'm in a small dark room. It' full of creepy energy all around...").
desctiption(office) :-
    write("    I'm standing in a middle of poorly lit, destroyed office room.
    Not many things are where they supposed to be. I feel like somebody must have pluderd it long time ago...").
desctiption(corridor) :-
    write("    Long corrior with paint flaking off the walls due to dense and hiumid air around.
    It`s connecting the office with the main room where I was trapped before... ").
%%%main_room
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
desctiption(chair) :-
    write("    Old chair lined with red fabric. 
    Looks comfy apart of clay mud wiped all over it...").
desctiption(window) :-
    write("    Dirty window looking out over moody forest. 
    Thermometer is hanging on the other side.
    On a window still sits a RAVEN in his NEST.
    I don't feel like opening a window with him (or her) on the other side.").
desctiption(vent_cover) :-
    write("    This vent cover looks big enouth for me to go inside...").
desctiption(heavy_door) :-
    write("    Big heavy door closed shut.
    Nail marks and scratches don't make me feel good about it...").

desctiption(_) :-
    write("    Nothing to be seen here...").

desctiption(_) :-
    write("    Nothing to be seen here...").

desctiption(_) :-
    write("    Nothing to be seen here...").

desctiption(_) :-
    write("    Nothing to be seen here...").

desctiption(_) :-
    write("    Nothing to be seen here...").

desctiption(_) :-
    write("    Nothing to be seen here...").

desctiption(_) :-
    write("    Nothing to be seen here...").


desctiption(_) :-
    write("    Nothing to be seen here...").


describe :- 
    current_pos(CurrentPlace),
    desctiption(CurrentPlace),
    !, nl.

