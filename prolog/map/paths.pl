:- dynamic path/2.

path(main_room, desk).
path(main_room, door).
path(door, corridor). %will be closed at the begining
path(main_room, chair).
path(chair, vent).

one_way_path(vent, office). %no chair, can't return to vent
one_way_path(main_room, office). %no chair, can't return to vent

% Bidirectional paths
path(Place, OtherPlace) :-
    \+ path(OtherPlace, Place), % Check if the reverse path doesn't already exist
    assert(path(OtherPlace,Place)).

path(place, otherplace).
% path()