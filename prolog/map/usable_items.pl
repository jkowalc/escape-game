:- ensure_loaded([
    'items'
]).

on_use(long_stick, nest) :-
    write("You succesfully hit the CROW. Not only it's now away from his nest, but also he left something behind."),
    (spawn_item(feather, window); spawn_item(screwdriver_bit, nest)).

on_use(long_stick, nest) :-
    !,nl.

on_use(_, _) :-
    write("You can't use that here."), nl.