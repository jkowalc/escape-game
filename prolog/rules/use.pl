:- ensure_loaded([
    '../map/usable_items',
    'inventory',
    'moving'
]).

use(litte_key) :-
    holding(litte_key),
    on_use(handcuffs, litte_key),nl,!.

use(Item) :-
    holding(Item),
    current_pos(CurrentPlace),
    on_use(CurrentPlace, Item).
