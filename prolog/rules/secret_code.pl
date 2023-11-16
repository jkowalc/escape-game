/* These rules describes how to enter a code to an object */
:- ensure_loaded('../map/paths').
:- dynamic trueCode/2.

enter_code(Lock, Code) :-
    trueCode(Lock, Correct_Code),

    !,nl.

enter_code(_, _) :-
    write("Lock like this doesn't exist!"),
    nl.