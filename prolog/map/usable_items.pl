:- ensure_loaded([
    'items'
]).

on_use(long_stick, nest) :-
    write("You succesfully hit the CROW. Not only it's now away from his nest, but also he left something behind."),
    (spawn_item(feather, window); spawn_item(screwdriver_bit, nest)).

on_use(long_stick, nest) :-
    write("     I've succesfully pushed the RAVEN avay. Not only it's now away from his nest, but also he left something behind.
    ---NEW ITEM---"),
    retract(subplace(window, raven)),
    assert(subplace(window, nest)),
    assert(pickable_item_at(feather, window)),
    % assert(pickable_item_at(screwdriver_bit, nest)),%done in examine nest
    !,nl.

on_use(cheese, rat) :- 
    write("     I baited the rat outside of the vent. I can crawl across it now.
    ---PATH UNLOCKED---"), nl,
    assert(path(vent, office)), !.

on_use(screwdriver, vent_cover) :- 
    write("     I menaged to loosen the screws holding the vent cover. Now I can climb up to the vent itself.
    ---PATH UNLOCKED---"), nl,
    retract(subplace(chair,vent_cover)),
    assert(path(chair, vent)), 
    look,!.

on_use(_, _) :-
    write("You can't use that here."), nl.