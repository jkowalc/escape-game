:- ensure_loaded([
    'items',
    '../rules/moving'
]).

on_use(long_stick, nest) :-
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

on_use(computer, hard_drive):-
    holding(assembly_manual),
    write("I managed to insert the hard drive to the computer,
    It should be working now!"),
    retract(withoutHardDrive(computer)),!,nl.

on_use(computer, hard_drive) :-
    write("I don't know how to insert the hard drive to the computer.
    If only there was any manual..."), !, nl.

on_use(computer, feather) :-
    turnedOff(computer),
    write("I managed to turn ON the computer!"),
    retract(turnedOff(computer)),
    !, nl.

on_use(computer, feather) :-
    write("I managed to turn OFF the computer!"),
    assert(turnedOff(computer)),
    !, nl.

on_use(handcuffs, small_key) :-
    write("I managed to open these handcuffs, they may be useful later, so I'll keep them."),nl,
    assert(holding(open_handcuffs)),
    retract(holding(litte_key)),
    retract(handcuffed),
    retract(holding(handcuffs)),nl,!.

on_use(_, _) :-
    write("You can't use that here."), nl.