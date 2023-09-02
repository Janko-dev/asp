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



#const k = 12.

div_not_by_one(X) :- X = 1..10, I = 2..X-1, X\I = 0.

coprime(X) :- X = 1..10, not div_not_by_one(X).