

% constant symbols
can(a; b; c).

% statics
static(cap(a, 8)).
static(cap(b, 5)).
static(cap(c, 3)).

% inertial fluents
fluent(inertial, amt(C, 0..A)) :- can(C), static(cap(C, A)).

% actions
action(move(C, C')) :- can(C), can(C'), C != C'.

% steps 0..n
#const n = 1.
step(0..n).

% causal law: move(X, Y) causes amt(Y, N) 
% if amt(X, C1), amt(Y, C2), cap(Y, T), N = min(T, C1+C2)
holds(amt(Y, N), I+1) :- occurs(move(X, Y), I), 
                         holds(amt(X, C1), I), 
                         holds(amt(Y, C2), I), 
                         static(cap(Y, T)), 
                         N = #min{T; C1+C2}.

% causal law: move(X, Y) causes amt(X, N) 
% if amt(X, C1), amt(Y, C2), cap(Y, T), N = max(0, C1-(T-C2))
holds(amt(X, N), I+1) :- occurs(move(X, Y), I), 
                         holds(amt(X, C1), I), 
                         holds(amt(Y, C2), I), 
                         static(cap(Y, T)), 
                         N = #max{C1-(T-C2); 0}. 

% state constraint: the same watercan cannot 
% have two different amounts of water during the same step I 
-holds(amt(X, A), I) :- holds(amt(X, A'), I), 
                        static(cap(X, T)), 
                        A = 0..T, 
                        A != A'.

% executability condition: cannot move from X to Y when can Y is full
-occurs(move(X, Y), I) :- static(cap(Y, T)),
                          holds(amt(X, A'), I),
                          holds(amt(Y, A), I),
                          A = T.

% executability condition: cannot move from X to Y when can X is empty
-occurs(move(X, Y), I) :- holds(amt(X, 0), I), holds(amt(Y, A), I).

% inertia axiom
holds(F, I+1) :- fluent(inertial, F),
                 holds(F, I),
                 not -holds(F, I+1),
                 I < n.

-holds(F, I+1) :- fluent(inertial, F),
                 -holds(F, I),
                 not holds(F, I+1),
                 I < n.

% CWA for actions
-occurs(A, I) :- action(A), step(I), not occurs(A, I).

% initial state
holds(amt(a, 8), 0).
holds(amt(b, 0), 0).
holds(amt(c, 0), 0).

% goal state
goal(I) :- holds(amt(a, 4), I), 
           holds(amt(b, 4), I), 
           holds(amt(c, 0), I).

% derive success answer sets
success :- goal(I), I <= n.
:- not success.

% % generate actions
{ occurs(A, I) : action(A) } = 1 :- step(I), not goal(I), I < n.

% minimize the amount of moves to find shortest plan
#minimize{1, I : occurs(A, I)}.

#show occurs/2.