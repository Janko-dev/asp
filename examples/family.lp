% small family
person(john).
person(alice).
person(sam).

father(john, sam).
mother(alice, sam).

% relative family
person(bob).
person(pat).

father(bob, pat).

% connecting the family trees
brother(john, bob).

% parent relation
parent(X, Y) :- father(X, Y).
parent(X, Y) :- mother(X, Y).

% symmetric relation
brother(X, Y) :- brother(Y, X).

% uncle definition
uncle(X, Y) :- brother(X, Z), parent(Z, Y).

-uncle(X, Y) :- person(X), 
                person(Y), 
                not uncle(X, Y).

#show uncle/2.
% #show -uncle/2.