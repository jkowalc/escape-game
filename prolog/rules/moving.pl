:- dynamic current_pos/1.
:- ensure_loaded('../map/paths').

move(Place) :- %used for forced movemnet of player.
    current_pos(CurrentPlace),
    retract(current_pos(CurrentPlace)),
    assert(current_pos(Place)),
    nl.

go(Place) :- 
    current_pos(CurrentPlace),
    (path(CurrentPlace, Place) ; reverse_path(CurrentPlace,Place)),
    retract(current_pos(CurrentPlace)),
    assert(current_pos(Place)),
    move(Place),
    look,
    !, nl.

go(_) :-
    write('You can\'t go there'),
    !, nl.

look :-
    current_pos(CurrentPlace),
    write('Possible destinations: '), nl,
    findall(Place, path(CurrentPlace, Place), Places),
    print_places(Places),
    findall(Place, reverse_path(CurrentPlace, Place), R_Places),
    print_places(R_Places).

print_places([]).
print_places([Place | Rest]) :-
    write(Place), nl,
    print_places(Rest).
 