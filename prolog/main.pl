:- ensure_loaded([
    rules/inventory,
    rules/moving
]).

clear_all :-
    retractall(current_pos(_)), retractall(item_at(_, _)), retractall(holding(_)).

clear_all.

starting_conditions :-
    assert(current_pos(place)).


h :- 
    instructions,
    nl.

instructions :-
    write('Instructions or h - will write this message'), nl,
    write('go(Place) - will try to move you closer to something') ,nl,
    write('look or look_around - will tell you what is around you'),nl,
    write('investigate - you will try to find out about thing you are standing next to'), nl,
    write('take(Item)'),nl,
    write('drop(Item)'),nl,
    write('inventory - will list ontents of your inventory'),nl,
    nl.

start :- 
    clear_all,
    instructions,
    starting_conditions,
    !, nl.