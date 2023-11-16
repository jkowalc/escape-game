:- ensure_loaded([
    rules/inventory,
    rules/moving,
    rules/secret_code,
    rules/interaction
]).

clear_all :-
    retractall(current_pos(_)), 
    % retractall(item_at(_, _)),
    retractall(holding(_)).

clear_all.

starting_conditions :-
    assert(current_pos(main_room)).

h :- 
    instructions,
    nl.

instructions :-
    write("Instructions"), nl,
    write("-------------------------------------------------------------"), nl,
    write("look.\t\tfind out what is around you"),nl,
    write("go(Place).\tgo to a place") ,nl,
    write("examine(Thing).\tfind more details about the specified thing or place"), nl,
    write("examine.\tfind out more about the current place"), nl,
    write("take(Item).\ttake specified item"),nl,
    write("drop(Item).\tdrop specified item on the ground"),nl,
    write("inventory.\tlist contents of your inventory"),nl,
    write("h.\t\tlist these instructions again"),nl,
    nl.

start :- 
    tty_clear,
    clear_all,
    instructions,
    starting_conditions,
    !.