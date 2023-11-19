:- dynamic pickable_item_at/2.

:- dynamic item_spawned/1.

spawn_item(Item, Place) :-
    \+ item_spawned(Item),
    assert(pickable_item_at(Item, Place)),
    assert(item_spawned(Item)),
    write('---NEW ITEM---').