
#const r = 1.
#const c = 3.

rows(1..r).
cols(1..c).

state(coast; sea; mountain).

{ cell(R, C, S, 0): state(S) } = 1 :- R = 1..r, C = 1..c.

% initial state collapsed
collapsed(1, 2, coast, 0).
% collapsed(2, 1, coast, 0).

:- collapsed(R, C, S1, T), cell(R, C, S2, T), S1 != S2.

% DIR(X, Y): X can be placed to the DIR of Y
% down(coast, mountain).
% down(coast, coast).
% down(sea, coast).
% right(mountain, mountain).
% right(coast, mountain).
% right(coast, coast).
% right(sea, sea).

right(sea, coast).
right(sea, sea).

% M M C
% C C C
% S S S

% { cell(R, C, S, 1) : cell(R, C, S, 0) }. 


:- right(S1, S2), collapsed(R, C, S2, T), not cell(R, C+1, S1, T).

% :- left(S1, S2), cell(R, C-1, S1, _), not cell(R, C, S2, _), rows(R), cols(C).
% :- right(S1, S2), cell(R, C+1, S1, _), not cell(R, C, S2, _), rows(R), cols(C).
% :- up(S1, S2), cell(R+1, C, S1, _), not cell(R, C, S2, _), rows(R), cols(C).
% :- down(S1, S2), cell(R-1, C, S1, _), not cell(R, C, S2, _), rows(R), cols(C).


% rule: (M, C, UP)
% :- cell(R, C, blue, T), cell(R, C+1, green, T).

% % rule: [blue][blue][] 
% :- cell(R, C, blue, T), cell(R, C+1, blue, T).

% entropy(R, C, X) :- X = #count{ cell(R, C, S, _): state(S) }, rows(R), cols(C).

entropy(R, C, X) :- X = #count{ R : cell(R, C, S, _) }, cell(R, C, _, _).

#show cell/4.
#show entropy/3.

% #show collapsed/4.
