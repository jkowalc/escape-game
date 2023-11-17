:- dynamic lock_opened/1.

%%%%% example how to use
% trueCode(myLock, 1).
% item_at(myLock, main_room).
%
%
% doWhenOpenedLock(myLock) :-
%    lock_opened(myLock),
%    assert(holding(gigaKubica)),
%    write("You've got an gigaKubica item!"),
%    !, nl.
%

trueCode(computer, 4321).
trueCode(color_code, yellowRedGreenBlue).

doWhenOpenedLock(computer) :-
    lock_opened(computer),
    retract(blockedWithPassword(computer)),
    write("You logged in!"),
    !,nl.



doWhenOpenedLock(color_code) :-
    lock_opened(color_code),
    assert(pickable_item_at(screwdriver_handle, wooden_box)),
    write("You opened the box!
    ---ITEM FOUND---"),
    !,nl.


doWhenOpenedLock(_) :-
    write("Lock is closed"),
    nl.
