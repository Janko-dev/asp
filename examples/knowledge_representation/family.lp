% small family
person(john).
person(alice).
person(sam).

gender_of(john, male).
gender_of(alice, female).
gender_of(sam, male).

father(john, sam).
mother(alice, sam).

% relative family
person(bob).
person(pat).

gender_of(bob, male).
gender_of(pat, male).

father(bob, pat).

% connecting the family trees
brother(john, bob).

% parent relation
parent(X, Y) :- father(X, Y).
parent(X, Y) :- mother(X, Y).

% symmetric relation
brother(X, Y) :- brother(Y, X).
brother(X, Y) :- gender_of(X, male),
                 father(F, X),
                 father(F, Y),
                 mother(M, X),
                 mother(M, Y),
                 X != Y.

% uncle definition
uncle(X, Y) :- brother(X, Z), parent(Z, Y).

-uncle(X, Y) :- person(X), 
                person(Y), 
                not uncle(X, Y).

#show uncle/2.
% #show -uncle/2.