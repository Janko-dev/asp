
% Timesteps 0..n
#const n = 1.

% constant symbols can a, b, c
can(a; b; c).

% capacity of a, b, c in liters
cap(a, 8).
cap(b, 5).
cap(c, 3).

% initial state
init(a, 8; b, 0; c, 0).

% goal state
goal(I) :- holds(curr(a, 4), I), 
           holds(curr(b, 4), I), 
           holds(curr(c, 0), I).

% generate start state predicate at time step 0
holds(curr(X, A), 0) :- init(X, A).

% generate for each time step, all possible transitions
{ 
  occurs(move(X, Y), I) : can(X), can(Y), X != Y
} = 1 :- I = 0..n-1, not goal(I).

% derive all states based on transitions 
holds(curr(X, N), I+1) :- occurs(move(X, Y), I), holds(curr(X, C1), I), holds(curr(Y, C2), I), cap(Y, T), N = #max{C1-(T-C2); 0}.
holds(curr(Y, N), I+1) :- occurs(move(X, Y), I), holds(curr(X, C1), I), holds(curr(Y, C2), I), cap(Y, T), N = #min{T; C1+C2}.

% inertia: all states must be present at every time step
{ holds(X, I+1) } :- holds(X, I), I = 0..n-1.

% every time step must contain exactly one holds/2 predicate for all cans
:- #count{ 1, X, A: holds(curr(X, A), I) } != 1, can(X), I = 0..n.

% derive success answer sets
success :- goal(I), I <= n.
:- not success.

% maximize amount of wait transitions, which leads to shortest plan
#minimize{ 1,I : occurs(A, I) }.

#show occurs/2.
% #show holds/2.



