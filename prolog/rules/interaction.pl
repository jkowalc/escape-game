:- ensure_loaded([
   'moving',
   '../map/details',
   '../map/subplaces' 
]).

examine(Thing) :-
   current_pos(Thing),
   examination(Thing),
   !.

examine(Thing) :-
   current_pos(CurrentPlace),
   subplace(CurrentPlace, Thing),
   examination(Thing),
   !.

examine(Thing) :-
   holding(Thing),
   examination(Thing),
   !.

examine(Thing) :-
   current_pos(CurrentPlace),
   pickable_item_at(CurrentPlace, Thing),
   examination(Thing),
   !.

examine :- 
   current_pos(CurrentPlace),
   examine(CurrentPlace).