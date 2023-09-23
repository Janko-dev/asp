
#const n = 2.

letter(a; b).

{ filled(R, C, L): letter(L) } = 1 :- R = 1..n, C = 1..n.

:- not filled(_, C, L), C = 1..n, letter(L).

% :- not filled(_, 1, a), letter(a).
% :- not filled(_, 2, a), letter(a).

% :- not filled(_, 1, b), letter(b).
% :- not filled(_, 2, b), letter(b).


% :- not filled(R, _, L), R = 1..n, letter(L).

% :- filled(R1, C1, L), filled(R2, C2, L), M = 1..n, R1 = R2 - M, C1 = C2 - M.
% :- filled(R1, C1, L), filled(R2, C2, L), M = 1..n, R1 = R2 - M, C1 = C2 + M.

% row1col2(L) :- filled(1, 2, L).

% #show row1col2/1.