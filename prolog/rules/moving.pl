:- dynamic current_pos/1.
:- ensure_loaded([
    '../map/paths',
    '../map/descriptions'
]).

move(Place) :- %used for forced movemnet of player.
    current_pos(CurrentPlace),
    retract(current_pos(CurrentPlace)),
    assert(current_pos(Place)),
    nl.

go(Place) :- 
    current_pos(CurrentPlace),
    path(CurrentPlace, Place),
    retract(current_pos(CurrentPlace)),
    assert(current_pos(Place)),
    description(Place),
    look,
    !, nl.

go(_) :-
    write('You can\'t go there'),
    !, nl.

look :- 
    current_pos(CurrentPlace),
    write('Possible destinations: '),
    path(CurrentPlace, Place),
    write(Place), write(" "), 
    fail.

look :-
    !.