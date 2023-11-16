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



doWhenOpenedLock(_) :-
    write("Lock is closed"),
    nl.
