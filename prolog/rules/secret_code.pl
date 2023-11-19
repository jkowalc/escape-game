/* These rules describes how to enter a code to an object */
:- dynamic trueCode/2, item_at/2, holding/1, current_pos/1, lock_closed/1, doWhenOpenedLock/1.
:- ensure_loaded('../map/codes').
:- ensure_loaded('inventory').
:- ensure_loaded('moving').

enter_code(Lock, _) :-
    lock_opened(Lock),
    write("Lock is already opened"),
    !, nl.

enter_code(Lock, Code) :-
    current_pos(CurrentPlace),
    (item_at(Lock, CurrentPlace); pickable_item_at(Lock, CurrentPlace); current_pos(CurrentPlace); subplace(CurrentPlace, Lock)),
    check_code(Lock, Code),!, nl.

enter_code(Lock, _) :-
    current_pos(CurrentPlace),
    (item_at(Lock, CurrentPlace); pickable_item_at(Lock, CurrentPlace); current_pos(CurrentPlace); subplace(CurrentPlace, Lock)),
    write("Wrong code!"),
    !, nl.

enter_code(Lock, _) :-
    (item_at(Lock, _); pickable_item_at(Lock, _); current_pos(_); subplace(_, Lock)),
    write("You are not nearby the lock!"),
    !, nl.

enter_code(_, _) :-
    write("Lock doesn't exist!"),
    !, nl.

check_code(Lock, Code) :-
    trueCode(Lock, Code),
    assert(lock_opened(Lock)),
    write("Lock opened!"), nl,
    doWhenOpenedLock(Lock).