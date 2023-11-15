:- dynamic path/2.

%%%%% MAIN ROOM
path(main_room, desk).
path(desk, top_drawer).
path(desk, mid_drawer).
path(desk, bottom_drawer).
path(main_room, bed).
path(bed, sit_on_bed).
path(main_room, painting).
path(painting, corner).
path(main_room, window).
path(window, nest).
path(window, outside).
path(window, thermometer).
path(main_room, fire_place).
path(main_room, chair).
path(chair, vent_cover).
path(vent_cover, vent).
path(chair, vent).

%%%%% OFFICE
path(office, coffee_table).
path(office, attic_entrance).
path(office, cupboard).
path(cupboard, left_compartment).
path(cupboard, midle_compartment).
path(cupboard, right_compartment).%has journal
%%%journal
path(right_compartment, journal).
path(journal, page_1).
path(journal, page_2).
path(journal, page_3).
path(page_3, half_torn_page_4). %open after examining page_3

%%%%%corridor
path(corridor, key_case). %has exit key
path(key_case, pad_10_digit).
path(corridor, dispaly_case). %has UV lamp

%%%%%zone changes
path(vent, office). %go to office
path(main_room, door).
path(door, corridor). %will be closed at the begining
path(office, corridor_door).
path(corridor_door, corridor).



% Bidirectional paths
reverse_path(Place, OtherPlace) :-
    path(OtherPlace, Place).

path(place, otherplace).
% path()