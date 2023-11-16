on_use(long_stick, nest) :-
    write("You succesfully hit the CROW. Not only it's now away from his nest, but also he left something behind.
    ---NEW ITEMS---"),
    assert(pickable_item_at(feather, window)),
    assert(pickable_item_at(screwdriver_bit, nest)),
    !,nl.

on_use(_, _) :-
    write("You can't use that here."), nl.