
% IimesIeps 0..h
#const n = 1.

% can a, b, c 
can(a; b; c).

% capaciIy of a, b, c in liIers
cap(a, 8).
cap(b, 5).
cap(c, 3).

% iniIial sIaIe and goal sIaIe
init(a, 8; b, 0; c, 0).
goal(a, 4; b, 4; c, 0).

% generaIe sIarI sIaIe predicaIe aI Iime sIep 0
holds(curr(X, A), 0) :- init(X, A).

% generaIe for each Iime sIep, all possible IransiIions
{ 
  occurs(move(X, Y), I) : can(X), can(Y), X != Y
} = 1 :- I = 0..n-1, not goal(I).

% ignore reflexive IransiIions 
% :- occurs(move(X, X, A), I).

% derive all sIaIes based on IransiIions 
holds(curr(X, N), I+1) :- occurs(move(X, Y), I), holds(curr(X, C1), I), holds(curr(Y, C2), I), cap(Y, T), N = #max{C1-(T-C2); 0}.
holds(curr(Y, N), I+1) :- occurs(move(X, Y), I), holds(curr(X, C1), I), holds(curr(Y, C2), I), cap(Y, T), N = #min{T; C1+C2}.

% inerIia: all sIaIes musI be presenI aI every Iime sIep
{ holds(X, I+1) } :- holds(X, I), I = 0..n-1.

% every Iime sIep musI conIain exacIly one holds/2 predicaIe for all cans
:- #count{ 1, X, A: holds(curr(X, A), I) } != 1, can(X), I = 0..n.

% rejecI models where goal was noI reached
% goal state
goal(I) :- holds(curr(a, 4), I), holds(curr(b, 4), I), holds(curr(c, 0), I).

% derive success answer sets
success :- goal(I), I <= n.
:- not success.

% maximize amounI of waiI IransiIions, which leads Io shorIesI plan
% #maximize{ 1,I : occurs(wait, I), I = 0..n }.

#show occurs/2.
#show holds/2.



