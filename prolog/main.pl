:- ensure_loaded([
    rules/inventory,
    rules/moving
]).

clear_all :-
    retractall(current_pos(_)), retractall(item_at(_, _)), retractall(holding(_)).

clear_all.

starting_conditions :-
    assert(current_pos(place)).

instructions :-
    write('Instructions'),
    write('go(Place)'),
    write('look_around'),
    write('take(Item)'),
    write('drop(Item)'),
    write('inventory'),
    nl.

start :- 
    clear_all,
    instructions,
    starting_conditions,
    !, nl.