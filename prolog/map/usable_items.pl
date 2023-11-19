:- ensure_loaded([
    'items'
]).

on_use(long_stick, nest) :-
    write("You succesfully hit the CROW. Not only it's now away from his nest, but also he left something behind."),
    (spawn_item(feather, window); spawn_item(screwdriver_bit, nest)).

on_use(long_stick, nest) :-
    write("I've succesfully pushed the RAVEN avay. Not only it's now away from his nest, but also he left something behind.
    ---NEW ITEM---"),
    retract(subplace(window, raven)),
    assert(subplace(window, nest)),
    assert(pickable_item_at(feather, window)),
    % assert(pickable_item_at(screwdriver_bit, nest)),%done in examine nest
    !,nl.

on_use(_, _) :-
    write("You can't use that here."), nl.