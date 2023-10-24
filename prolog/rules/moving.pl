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

% For debugging mainly. Can also be left in game if needed.
list_places :- 
    current_pos(CurrentPlace),
    write('Possible destinations: '),
    path(CurrentPlace, Place),
    write(Place), !, nl.