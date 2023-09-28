
% timesteps 0..h
#const h = 5.

% can a, b, c 
can(a; b; c).

% capacity of a, b, c in liters
cap(a, 8).
cap(b, 5).
cap(c, 3).

% initial state and goal state
init(a, 8; b, 0; c, 0).
goal(a, 4; b, 4; c, 0).

% generate start state predicate at time step 0
holds(curr(X, A), 0) :- init(X, A).

% generate for each time step, all possible transitions
{ 
  occurs(move(X, Y, 1..TotalAmt), T) : can(X), can(Y), cap(X, TotalAmt);
  occurs(wait, T) 
} = 1 :- T = 0..h-1.

% ignore reflexive transitions 
:- occurs(move(X, X, A), T).

% derive all states based on transitions 
holds(curr(X, C-A), T+1) :- occurs(move(X, Y, A), T), holds(curr(X, C), T), C-A > 0.
holds(curr(Y, C+A), T+1) :- occurs(move(X, Y, A), T), holds(curr(Y, C), T), cap(Y, TotalAmt), C+A <= TotalAmt.

% inertia: all states must be present at every time step
{ holds(X, T+1) } :- holds(X, T), T = 0..h-1.

% every time step must contain exactly one holds/2 predicate for all cans
:- #count{ A: holds(curr(X, A), T) } != 1, can(X), T = 0..h.

% reject models where goal was not reached
:- goal(X, A), not holds(curr(X, A), _).

% maximize amount of wait transitions, which leads to shortest plan
#maximize{ 1,T : occurs(wait, T), T = 0..h }.

#show occurs/2.


