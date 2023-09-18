
#const n = 8.

% Generate all possible ways to place queens on 8x8 board
{ q(1..n, 1..n) }.

% Exactly 1 queen on row/column  
:- not #count{ R : q(R, C) } = 1, C = 1..n.
:- not #count{ C : q(R, C) } = 1, R = 1..n.

% Generate all diagonals
d1(R, C, R-C+n) :- R = 1..n, C = 1..n.
d2(R, C, R+C-1) :- R = 1..n, C = 1..n.

% At most 1 queen per diagonal
:- D = 1..n*2-1, 2 { q(X, Y) : d1(X, Y, D) }.
:- D = 1..n*2-1, 2 { q(X, Y) : d2(X, Y, D) }.

#show q/2.