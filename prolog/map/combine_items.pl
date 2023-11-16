
make_screwdriver :-
    retract(holding(screwdriver_handle)),
    retract(holding(screwdriver_bit)),
    assert(holding(screwdriver)),
    write("     You created a screwdriver!").

on_combine(screwdriver_handle, screwdriver_bit) :-
    make_screwdriver.

on_combine(screwdriver_bit, screwdriver_handle) :-
    make_screwdriver.


on_combine(_, _) :-
    write("You can't combine these/any items"), fail.