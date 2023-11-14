:- dynamic path/2.

path(place, otherplace).

path(main_room, desk).

path(main_room, door).

path(door, corridor). %will be closed at the begining

path(room, chair).

path(chair, vent).

one_way_path(vent, office). %no chair, can't return to vent

path()


one_way_path(Place, OtherPlace):- 
    path(Place, OtherPlace).

path(Place, OtherPlace):-
    path(OtherPlace, Place).
