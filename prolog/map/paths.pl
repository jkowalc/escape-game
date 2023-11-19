:- dynamic path/2.

%%%%% MAIN ROOM
path(main_room, desk).
% path(desk, top_drawer).
% path(desk, mid_drawer).
% path(desk, bottom_drawer).
% path(main_room, bed). paths are created after alarm is disabled
% path(bed, sit_on_bed). paths are created after alarm is disabled
% path(main_room, painting). paths are created after alarm is disabled
% % path(painting, torn_corner). paths are created after alarm is disabled
% path(main_room, window). paths are created after alarm is disabled
% path(window, nest). paths are created after alarm is disabled
% path(window, outside). paths are created after alarm is disabled
% % path(window, thermometer). paths are created after alarm is disabled
% path(main_room, fire_place). paths are created after alarm is disabled
% path(main_room, chair). paths are created after alarm is disabled
% % path(chair, vent_cover). paths are created after alarm is disabled
% % path(vent_cover, vent). paths are created after alarm is disabled
% % path(chair, vent). paths are created after alarm is disabled
% path(main_room, wooden_box). paths are created after alarm is disabled


%%%%% OFFICE
path(office, coffee_table).
% path(office, attic_entrance).
path(office, cupboard).
path(office, computer).
% path(cupboard, left_compartment).
% path(cupboard, midle_compartment).
% path(cupboard, right_compartment).%has journal
%%%journal
% path(right_compartment, journal).
% path(journal, page_1).
% path(journal, page_2).
% path(journal, page_3).
% path(page_3, half_torn_page_4). %open after examining page_3

%%%%%corridor
path(corridor, key_case). %has exit key
path(key_case, pad_10_digit).
path(corridor, display_case). %has UV lamp
path(corridor, main_room_entrance).

%%%%%zone changes
% path(vent, office). %go to office
path(main_room, heavy_door).
% path(heavy_door, corridor). %will be closed at the begining
path(office, corridor_door).
path(corridor_door, corridor).

% path(place, otherplace).
% path()
