:- ensure_loaded([
   'moving',
   '../map/details',
   '../map/subplaces' 
]).

examine(Thing) :-
   current_pos(Thing),
   examination(Thing),
   !, nl.

examine(Thing) :-
   current_pos(CurrentPlace),
   subplace(CurrentPlace, Thing),
   examination(Thing),
   !, nl.

examine(Thing) :-
   holding(Thing),
   examination(Thing),
   !, nl.

examine(Thing) :-
   current_pos(CurrentPlace),
   pickable_item_at(CurrentPlace, Thing),
   examination(Thing),
   !, nl.

list_examine :-
   current_pos(CurrentPlace),
   \+ subplace(CurrentPlace, _),
   write('You can examine: '), write(CurrentPlace),
   !, nl.

list_examine :-
   current_pos(CurrentPlace),
   write('You can examine: '), write(CurrentPlace), write(' '),
   subplace(CurrentPlace, Place),
   write(Place), write(' '),
   fail.

list_examine :-
   !, nl.

examine :- 
   current_pos(CurrentPlace),
   examine(CurrentPlace).