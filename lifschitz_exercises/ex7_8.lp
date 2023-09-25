% Given a set p/1, what alternative ways are there
% to get the same result as the constrain
% :- not p(_).

p(a) | q(c).

% a) using count aggregate
:- #count{ X : p(X) } = 0.

% b) using max aggregate
:- #max{ X : p(X) } = #inf.

% c) using min aggregate
:- #min{ X : p(X) } = #sup.
