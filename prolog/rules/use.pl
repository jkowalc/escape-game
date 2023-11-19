:- ensure_loaded([
    '../map/usable_items',
    'inventory',
    '../map/subplaces'
]).

use(Item, Subplace) :-
    holding(Item),
    current_pos(CurrentPlace),
    subplace(CurrentPlace, Subplace),
    on_use(Item, Subplace).

use(Item) :-
    holding(Item),
    current_pos(CurrentPlace),
    on_use(Item, CurrentPlace).
