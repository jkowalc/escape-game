:- dynamic current_pos/1.
:- ensure_loaded([
    '../map/paths',
    '../map/on_arrival'
]).

move(Place) :- %used for forced movemnet of player.
    current_pos(CurrentPlace),
    retract(current_pos(CurrentPlace)),
    assert(current_pos(Place)),
    nl.

go(Place) :- 
    current_pos(CurrentPlace),
    (path(CurrentPlace, Place); path(Place, CurrentPlace)),
    retract(current_pos(CurrentPlace)),
    assert(current_pos(Place)),
    on_arrival(Place),
    look,
    !, nl.

go(_) :-
    write('You can\'t go there'),
    !, nl.


look :-
    current_pos(CurrentPlace),
    write('Possible destinations: '), nl,
    findall(Place, path(CurrentPlace, Place), Places),
    print_list(Places),
    write("There are interesting places aroud you: "),nl,
    findall(Subplace, subplace(CurrentPlace, Subplace), Subplaces),
    print_list(Subplaces),
    write("There are items aroudn you: "), nl,
    findall(Item, item_at(Item, CurrentPlace), Items),
    print_list(Items).

print_list([]):- nl.

print_list([Place | Rest]) :-
    write("-"),
    write(Place), nl,
    print_list(Rest).


% look :- 
%     current_pos(CurrentPlace),
%     write('Possible destinations: \n'),
%     (path(CurrentPlace, Place); path(Place, CurrentPlace)),
%     write("--- "), write(Place), write(" \n"), 
%     fail.

% look :- 
%     current_pos(CurrentPlace),
%     \+ pickable_item_at(_, CurrentPlace),
%     !. 

% look :-
%     current_pos(CurrentPlace),
%     write('There are items in this location: '),
%     pickable_item_at(Item, CurrentPlace),
%     write(Item), write(' '),
%     fail.

% look :-
%     !.

describe :- 
    current_pos(CurrentPlace),
    on_arrival(CurrentPlace),
    !, nl.
