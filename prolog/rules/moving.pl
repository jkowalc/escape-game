:- dynamic current_pos/1.
:- ensure_loaded([
    '../map/paths',
    '../map/on_arrival'
]).

move(Place) :- %used for forced movemnet of player.
    current_pos(CurrentPlace),
    retract(current_pos(CurrentPlace)),
    assert(current_pos(Place)),
    nl.

go(Place) :- 
    current_pos(CurrentPlace),
    (path(CurrentPlace, Place); path(Place, CurrentPlace)),
    retract(current_pos(CurrentPlace)),
    assert(current_pos(Place)),
    on_arrival(Place),
    look,
    !, nl.

go(_) :-
    write('You can\'t go there'),
    !, nl.

look :- 
    current_pos(CurrentPlace),
    write('Possible destinations: \n'),
    (path(CurrentPlace, Place); path(Place, CurrentPlace)),
    write("--- "), write(Place), write(" \n"), 
    fail.

look :- 
    current_pos(CurrentPlace),
    \+ pickable_item_at(_, CurrentPlace),
    !. 

look :-
    current_pos(CurrentPlace),
    write('There are items in this location: '),
    pickable_item_at(Item, CurrentPlace),
    write(Item), write(' '),
    fail.

look :-
    !.

describe :- 
    current_pos(CurrentPlace),
    on_arrival(CurrentPlace),
    !, nl.
