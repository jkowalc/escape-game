:- ensure_loaded([
    'items',
    '../rules/moving',
    '../rules/interaction'
]).

on_use(uv_flashlight, Place) :-
    lightable_by_uv(Place),
    examine(Place),nl,!.

on_use(uv_flashlight, _) :-
    write("    I cannot see anything new."),nl,!.

on_use(long_stick, raven) :-
    write("     I've succesfully pushed the RAVEN avay. Not only it's now away from his nest, but also he left something behind.
    ---NEW ITEM---"),
    retract(subplace(window, raven)),
    assert(subplace(window, nest)),
    assert(pickable_item_at(feather, window)),
    % assert(pickable_item_at(screwdriver_bit, nest)),%done in examine nest
    !,nl.

on_use(cheese, rat) :- 
    write("     I baited the rat outside of the vent. I can crawl across it now.
    ---PATH UNLOCKED---"), nl,
    assert(path(vent, office)), !.

on_use(screwdriver, vent_cover) :- 
    write("     I menaged to loosen the screws holding the vent cover. Now I can climb up to the vent itself.
    ---PATH UNLOCKED---"), nl,
    retract(subplace(chair,vent_cover)),
    assert(path(chair, vent)), 
    look,!.

on_use(hard_drive, computer):-
    holding(assembly_manual),
    write("     I managed to insert the hard drive to the computer,
    It should be working now!"),
    retract(withoutHardDrive(computer)),!,nl.

on_use(hard_drive, computer) :-
    write("     I don't know how to insert the hard drive to the computer.
    If only there was any manual..."), !, nl.

on_use(feather, computer) :-
    turnedOff(computer),
    write("     I managed to turn ON the computer!"),
    retract(turnedOff(computer)),
    !, nl.

on_use(feather, computer) :-
    write("     I managed to turn OFF the computer!"),
    assert(turnedOff(computer)),
    !, nl.

on_use(small_key, handcuffs) :-
    write("     I managed to open these handcuffs, they may be useful later, so I'll keep them."),nl,
    assert(holding(open_handcuffs)),
    retract(holding(litte_key)),
    retract(handcuffed),
    retract(holding(handcuffs)),nl,!.

on_use(exit_key, exit_door) :-
    write("     I see light! Freedom is mine!"),
    retract(holding(exit_key)),
    assert(path(corridor, the_end)),
    !,nl.

on_use(open_handcuffs, attic_entrance) :-
    write("     I managed to open the entrance to attic!
    I still cannot go there, but something has fallen out of it.
    "),nl,
    spawn_item(hard_drive, office),!,nl.

    
on_use(_, _) :-
    write("     You can't use that here."), nl.