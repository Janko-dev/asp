% Fill partially filled grid with letters (A, B, C, D, E)
% such that each letter occurs once in each row, column and 
% two diagonals.
% setup:
% _ ? _ _ _
% _ _ _ _ A
% _ _ B _ _
% D _ C _ _ 
% _ _ _ E _
% find letter for question mark

#const n = 5.

letter(a; b; c; d; e).

% initial grid
filled(2, 5, a).
filled(3, 3, b).
filled(4, 1, d).
filled(4, 3, c).
filled(5, 4, e).

% derive all possible letters for each row/column
{ filled(R, C, L): letter(L) } = 1 :- R = 1..n, C = 1..n.

% every letter must be in one of the columns 
:- not filled(_, C, L), C = 1..n, letter(L).
% every letter must be in one of the rows
:- not filled(R, _, L), R = 1..n, letter(L).

% for every pair of grid cells G1, G2, with the same letter L, if G1 = G2 - M, 
% where M is a vector (m, m)^T from 1..n, then reject these answer sets
% because G1 and G2 lie on the same diagonal (in direction \)
:- filled(R1, C1, L), filled(R2, C2, L), M = 1..n, R1 = R2 - M, C1 = C2 - M.

% for every pair of grid cells G1, G2, with the same letter L, if G1 = G2 + M, 
% where M is a vector (-m, m)^T from 1..n, then reject these answer sets
% because G1 and G2 lie on the same diagonal (in direction /)
:- filled(R1, C1, L), filled(R2, C2, L), M = 1..n, R1 = R2 - M, C1 = C2 + M.

% deduce question mark
row1col2(L) :- filled(1, 2, L).

#show row1col2/1.