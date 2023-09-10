% person(jan, 24). 
% person(anna, 24). 
% person(ani, 20).

% oldest(Name2) :- person(Name1, Age1), person(Name2, Age2), Age1 < Age2.

% num(0..1000).

% max(N2) :- num(N1), num(N2), N1 != N2, N2 > max(N1).

% pair(1, pair(2, pair(3, pair(4, null)))).

% test(N) :- pair(N, P), P != null.

% p(2**C, 2 * 2**C) :- C = 0..3.

% p(C, D) :- C = 1..4, D = 1..4, D <= C.

% obj(0). obj(1).

% tuple(X1, X2, X3, X4) :- obj(X1), obj(X2), obj(X3), obj(X4).

% #show tuple/4.

% p(a; b).

% { q(X, Y) } = 1 :- p(X), p(Y).

% { p(a); q(b) } .
% :- not p(a), not q(b).

% 1 { f(1, 3); f(1, 2); f(3, 4) } .
% :- f(X, Y1), f(X, Y2), Y1 != Y2.

% 3 * (2 + 1)

% penguin(tweety).

% flies(X) :- bird(X), not -flies(X).
% bird(X) :- penguin(X).
% -flies(X) :- penguin(X).


% cares(X, Y) :- parent(X, Y),
%                 not ab(d_cares(X, Y)),
%                 not -cares(X, Y).

% satisfiable
%  {p(b), p(a), p(c)} not minimal
%  {p(a), p(c)} not minimal
%  {p(c)} Minimal!!
% p(a) :- p(b). 
% p(c).

% satisfiable
%  {p(a), p(c)} Minimal!!
% p(a) :- not p(b). 
% p(c).

% p(a) :- not p(b), -p(c).
% p(b) :- not p(a), -p(c).
% -p(a) :- not p(a).
% -p(b) :- not p(b).
% -p(c) :- not p(c).

% -p(X) :- not p(X).


% p(a)


