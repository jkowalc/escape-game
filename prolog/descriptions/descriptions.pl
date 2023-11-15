:- ensure_loaded('../map/paths').

desctiption(main_room) :-
    write("You are in a small dark room full of creepy energy all around...").

desctiption(_) :-
    write("Nothing to be seen here...").


describe :- 
    current_pos(CurrentPlace),
    desctiption(CurrentPlace),
    !, nl.

