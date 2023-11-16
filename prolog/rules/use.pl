:- ensure_loaded([
    '../map/usable_items',
    'inventory',
    'moving'
]).

use(Item) :-
    holding(Item),
    current_pos(CurrentPlace),
    on_use(CurrentPlace, Item).
