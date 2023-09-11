car(a; b; c).
pick_up(b; c).
ext_cab(c).

ab(d_seat4(X)) :- pick_up(X).
ab(d_seat2(X)) :- ext_cab(X).

seat4(X) :- car(X),
            not ab(d_seat4(X)), 
            not -seat4(X).

seat2(X) :- pick_up(X),
            not ab(d_seat2(X)), 
            not -seat2(X).

seat4(X) :- ext_cab(X).


#show seat2/1.
#show -seat2/1.

#show seat4/1.
#show -seat4/1.