/* These rules describe how to pick up an object. */
:- ensure_loaded([
    'moving',
    '../map/items'
]).
:- dynamic holding/1.

take(Item) :-
    holding(Item),
    write("You're already holding it!"),
    !, nl.

take(Item) :-
    current_pos(Place),
    pickable_item_at(Item, Place),
    retract(pickable_item_at(Item, Place)),
    assert(holding(Item)),
    write("OK."),
    !, nl.

take(_) :-
    write("I don't see it here."),
    nl.


/* These rules describe how to put down an object. */

drop(Item) :-
    holding(Item),
    current_pos(Place),
    retract(holding(Item)),
    assert(pickable_item_at(Item, Place)),
    write("OK."),
    !, nl.

drop(_) :-
    write("You aren't holding it!"),
    nl.

inventory :- 
    write("Your inventory: "),
    holding(Item),
    write(Item), write(" "),
    !.