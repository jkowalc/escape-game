:- ensure_loaded([
    '../map/paths',
    '../rules/moving',
    '../rules/inventory'
]).
% :- discontiguous path/2.

%%%main_room
on_arrival(main_room):-
    alarm_rings,
    write("    I'm in a small dark room. I'm handcuffed! I don't remeber anything. Surroundig is dirty and the room is very cold...
    An alarm clock is ringing very loudly and is exploading my head. I have to go to the desk and examine it.
    Maybe I can disable the alarm."),!,nl.

on_arrival(main_room) :-
    write("    I'm in a small dark room. It' full of creepy energy all around...
    Surroundig is dirty and the room is very cold..."),nl.
on_arrival(desk) :-
    alarm_rings,
    write("    There's the alarm. I have to examine the desk, maybe I can disable the alarm."),!,nl.
on_arrival(desk) :-
    write("    An old desk covered with dust. 
    The chair was mooved to the other end of a room, so I can't sit here..."),nl.
on_arrival(fire_place) :-
    write("    It's and big antique fireplace.
    I wish it was lit so I could warm myself up. 
    Unfortunetly without matches even the half bured CANDLE sitting on top will be no use for me..."),nl.
on_arrival(painting) :-
    write("    It's a mastepice I've seen in history books.
    It is beatifull, at least it was... before someone dameged it"),nl.
on_arrival(torn_corner) :-
    write("    It's a torn corner of a painting. 
    Fabric is deattached from glded wooden frame."),nl.
on_arrival(chair) :-
    write("    Old chair lined with red fabric. 
    Looks comfy apart of clay mud wiped all over it..."),nl.
on_arrival(vent) :-
    write("    There is a RAT in here!
    ---NEW PLACE UNLOCKED---"),nl,
    assert(subplace(vent, rat)).
on_arrival(bed) :-
    write("    In diferent situation, I would love to take a nap. Bed looks komfy, especially with that big PILLOW.
    I guess I can take a sit for a while to think..."), nl,
    spawn_item(pillow, bed),
    fail.
on_arrival(bed) :-
    !, nl.
on_arrival(sit_on_bed) :-
    write("    The bed is sqeeqing and the blanket is itchy.
    But it feels good to rest for a second."),nl.
on_arrival(window) :-
    write("    Dirty window looking out over moody forest. 
    Thermometer is hanging on the other side.
    On a window still sits a RAVEN in his NEST.
    I don't feel like opening a window with him (or her) on the other side.
    ---NEW PLACE UNLOCKED---"),nl,
    assert(subplace(window, raven)).
%%%%%%%%%%%%%%%%%%%%%%%%office
on_arrival(office) :-
    write("    I'm standing in a middle of poorly lit, destroyed office room.
    Not many things are where they supposed to be. I feel like somebody must have pluderd it long time ago..."),nl.
on_arrival(coffee_table) :-
    write("    I don't feel right about that coffee table. It's wiped clean of dust comared to the rest of the room."),nl.
on_arrival(computer) :-
    write("    Old PC. It's turned off. I hope it's OS was made in this centry..."),nl.
on_arrival(attic_entrance) :-
    write("    Old trapdoor. I can't reach it in any way possible..."),nl.
on_arrival(cupboard) :-
    write("    Wide cupboard. It's rotting away abaut to fall appart.
    It has 3 compartments. I'should check if there is something usefull in there.
    ---NEW PLACES UNLOCKED---"),
    assert(subplace(cupboard, left_compartment)),
    assert(subplace(cupboard, middle_compartment)),
    assert(subplace(cupboard, right_compartment)),nl.%has journal.

on_arrival(journal) :-
    write("    I opened an old journal I've found. It's dusty but I still want to find out more about it."),nl. %examine for more info


on_arrival(office_safe) :-
    write("    Small but sturdy. Too havy to lift. 
    It opens by unlocking a turning code mechanism"),nl.

%%%%%%%%%%%corridor
on_arrival(corridor) :-
    write("    Long corrior with paint flaking off the walls due to dense and hiumid air around.
    It`s connecting the office with the main room where I was trapped before... "),nl.
on_arrival(display_case) :-
    write("    Glass display case, there is something inside"), nl,!.
    %spawn_item(uv_flashlight,display_case), fail.
on_arrival(display_case) :-
    !, nl.
on_arrival(key_case) :-
    write("    Locked key box. Big beautifull key is stored inside. 
    It has to be opened by inputing a code on a keypad"),nl.
on_arrival(baricated_door) :-
    write("     I'm on the other side of that heavy door. It's blocked with rumble. I can unlock it now and go back to main room
    ---PATH UNLOCKED---"),
    assert(path(corridor, main_room)),
    retract(subplace(main_room, heavy_door)),
    retract(subplace(corridor,baricated_door)),
    look.
on_arrival(exit_door) :-
    write("    It's my way out. I just need a key to open it."),!,nl.

on_arrival(the_end) :-
    write("     CONGRATULATIONS YOU COMPLETED THE GAME!"),nl,
    retract(path(corridor, the_end)),!,nl.


on_arrival(_) :-
    write("     I can't see anything!").
