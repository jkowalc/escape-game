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
    write('Possible destinations: '),
    path(CurrentPlace, Place),
    write(Place), !, nl.