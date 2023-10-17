rule(p, ()).
rule(q, (p)).
rule(r, (p, q)).
rule(y, (x)).

% { t(X) : rule(X, Y) } :- rule(_, Y).

% :- 

% #maximize{ 1, X : t(X) }.

dep(X, ()) :- rule(X, ()).
dep(X, Z) :- rule(X, (Y)), rule((Y), Z).
dep(X, Z) :- rule(X, (Y1, _)), dep(Y1, Z).
dep(X, Z) :- rule(X, (_, Y1)), dep(Y2, Z).
% dep(X, Z) :- rule(X, (Y)), dep(Y, (Z)).

t(X) :- dep(X, _).


#show t/1.
% #show dep/2.
