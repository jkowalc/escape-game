:- ensure_loaded([
   '../map/details',
   'moving'
]).

inspect :- 
   current_pos(CurrentPlace),
   examine(CurrentPlace),
   !, nl.