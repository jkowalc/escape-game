:- dynamic current_pos/1.
:- ensure_loaded('../map/paths').

go(Place) :- 
    current_pos(CurrentPlace),
    path(CurrentPlace, Place),
    retract(current_pos(CurrentPlace)),
    assert(current_pos(Place)),
    !, nl.

go(_) :-
    write('You can\'t go there'),
    !, nl.

look :-
    look_around.

look_around :-
    current_pos(CurrentPlace),
    write('Possible destinations: '), nl,
    findall(Place, path(CurrentPlace, Place), Places),
    print_places(Places),
    (   findall(OneWayPlace, one_way_path(CurrentPlace, OneWayPlace), OneWayPlaces),
        OneWayPlaces \= []  % Check if OneWayPlaces is not an empty list
    ->  write('One-way destinations: '), nl,
        print_places(OneWayPlaces)
    ;   true  % Do nothing if OneWayPlaces is an empty list
    ).

print_places([]).
print_places([Place | Rest]) :-
    write(Place), nl,
    print_places(Rest).
