:- dynamic current_pos/1.
:- ensure_loaded([
    '../map/paths',
    '../map/on_arrival'
]).

:- dynamic handcuffed/0.

move(Place) :- %used for forced movemnet of player.
    current_pos(CurrentPlace),
    retract(current_pos(CurrentPlace)),
    assert(current_pos(Place)),
    nl.

go(desk):-
    current_pos(CurrentPlace),
    (path(CurrentPlace, desk); path(desk, CurrentPlace)),
    retract(current_pos(CurrentPlace)),
    assert(current_pos(desk)),
    on_arrival(desk),
    look,
    !, nl.

go(_) :-
    alarm_rings,
    write("    The sound of the alarm clock is so disturbing that I can't go there.
    I have to go to the desk to disable it!"),nl,nl,
    write("    Failed to go there!"),!,nl.


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
    look_destinations(CurrentPlace),
    look_interesting_places(CurrentPlace),
    look_items(CurrentPlace).

look_destinations(CurrentPlace) :-
    findall(Place, path(CurrentPlace, Place), Places),
    (   Places = [] 
    ->  true
    ;   write('Possible destinations: '), nl,
        print_list(Places)
    ).

look_interesting_places(CurrentPlace) :-
    findall(Subplace, subplace(CurrentPlace, Subplace), Subplaces),
    (   Subplaces = []
    ->  true
    ;   write("There are interesting places around you: "), nl,
        print_list(Subplaces)
    ).

look_items(CurrentPlace) :-
    findall(Item, item_at(Item, CurrentPlace), Items),
    (   Items = []
    ->  true
    ;   write("There are items around you: "), nl,
        print_list(Items)
    ).

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
