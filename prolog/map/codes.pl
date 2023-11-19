:- dynamic lock_opened/1.

%%%%% example how to use
% trueCode(myLock, 1).
% item_at(myLock, main_room).
%
%
% doWhenOpenedLock(myLock) :-
%    lock_opened(myLock),
%    assert(holding(gigaKubica)),
%    write("I've got an gigaKubica item!"),
%    !, nl.
%
trueCode(vault, 85023).
trueCode(computer, 4321).
trueCode(color_code, whispers_of_the_abyss).
trueCode(pad_10_digit, 21037).

doWhenOpenedLock(vault) :-
    lock_opened(vault),
    write("     I opened the vault"),nl,
    spawn_item(corridor_key, coffee_table),nl,!.

doWhenOpenedLock(pad_10_digit) :-
    lock_opened(pad_10_digit),
    write("     I opened the key case!"),nl,
    spawn_item(exit_key, key_case),!,nl.

doWhenOpenedLock(computer) :-
    lock_opened(computer),
    retract(blockedWithPassword(computer)),
    write("     I logged in!"),
    !,nl.



doWhenOpenedLock(color_code) :-
    lock_opened(color_code),
    write("     I opened the box!"),nl,
    spawn_item(screwdriver_handle, wooden_box),
    !,nl.


doWhenOpenedLock(_) :-
    write("     Lock is closed"),
    nl.
