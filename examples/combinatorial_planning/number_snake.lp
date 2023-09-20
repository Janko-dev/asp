
% initial filled in cells
filled(1, 1, 6).
filled(3, 1, 1).
filled(2, 2, 2).
filled(2, 3, 8).

% grid representation
n(1..9).
row(1..3).
col(1..3).

% generate all possible cells (excluding existing cells)
{ filled(R, C, N) : n(N) } = 1 :- row(R), col(C).

% no two different numbers in each row 
% :- filled(R1, _, N), filled(R2, _, N), R1 != R2.
% no two different numbers in each column
% :- filled(_, C1, N), filled(_, C2, N), C1 != C2.

% every number between 1 and 9 is included
:- not filled(_, _, N), N = 1..9.

% any two cells with consecutive numbers must be next to each other.
% the euclidean distance formula is used here.
:- filled(R1, C1, N), filled(R2, C2, N+1), (R1-R2)**2 + (C1-C2)**2 > 2.

#show filled/3.