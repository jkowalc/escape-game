:- ensure_loaded([
   'inventory',
   '../map/combine_items' 
]).

% combine :-
%     holding(Item),
%     holding(OtherItem),
%     on_combine(Item, OtherItem).

combine(Item, OtherItem) :-
    holding(Item),
    holding(OtherItem),
    on_combine(Item, OtherItem).