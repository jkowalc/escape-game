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
    write("Instructions or h - will write this message"), nl,
    write("go(Place) - will try to move you closer to something") ,nl,
    write("look - will tell you what is around you"),nl,
    write("investigate - you will try to find out about thing you are standing next to"), nl,
    write("describe - you will try decribe surroundings best you can"), nl,
    write("inspect - you will try find more details about the place you are in"), nl,
    write("take(Item)"),nl,
    write("drop(Item)"),nl,
    write("inventory - will list ontents of your inventory"),nl,
    write("enter_code(lock, code) - enters a code to a lock"),nl,
    nl.

start :- 
    tty_clear,
    clear_all,
    instructions,
    starting_conditions,
    !.