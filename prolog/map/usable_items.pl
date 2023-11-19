:- ensure_loaded([
    'items'
]).

on_use(nest, long_stick) :-
    write("I succesfully hit the CROW. Not only it's now away from his nest, but also it left something behind."),
    (spawn_item(feather, window); spawn_item(screwdriver_bit, nest)).

on_use(nest, long_stick) :-
    !,nl.

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

on_use(handcuffs, litte_key) :-
    write("I managed to open these handcuffs, they may be useful later, so I'll keep them."),nl,
    assert(holding(open_handcuffs)),
    retract(holding(litte_key)),
    retract(handcuffed),
    retract(holding(handcuffs)),nl,!.

on_use(_, _) :-
    write("You can't use that here."), nl.