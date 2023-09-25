
% { a }.
% b : - a .
% c : - not a .

rule(choice(0), normal(0)).
atom_tuple(0).      literal_tuple(0).
atom_tuple(0, 1).

rule(disjunction(1), normal(1)).
atom_tuple(1).      literal_tuple(1).
atom_tuple(1, 2).   literal_tuple(1, -1).

rule(disjunction(2), normal(2)).
atom_tuple(2).      literal_tuple(2).
atom_tuple(2, 3).   literal_tuple(2, 1).

output(a, 2).
output(b, 3).       literal_tuple(3).
literal_tuple(3, 3).
output(c, 4).       literal_tuple (4).
literal_tuple (4, 2).





body(normal(B)) :- rule(_, normal(B)), conjunction(B).

hold(A) : atom_tuple(H, A) :- rule(disjunction(H), B), body(B).
{ hold(A) : atom_tuple(H, A) } :- rule(choice(H), B), body(B).

conjunction(B) :- literal_tuple(B), 
        hold(L) : literal_tuple(B, L), L > 0; 
    not hold(L) : literal_tuple(B, -L), L > 0.

#show hold/1.
#show T : output(T, B), conjunction(B).
