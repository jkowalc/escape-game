:- dynamic subplace/2.
:- dynamic subplace_spawned/1.


spawn_subplace(Place, Subplace) :-
    \+ subplace_spawned(Subplace),
    assert(subplace(Place, Subplace)),
    assert(subplace_spawned(Subplace)),
    write('---NEW PLACE DISCOVERED---'), nl.

subplace(main_room, heavy_door).
subplace(corridor, baricated_door).
subplace(key_case, pad_10_digit).
subplace(corridor, exit_door).
subplace(office, attic_entrance).
subplace(office, corridor_door).
subplace(bed, sit_on_bed).
