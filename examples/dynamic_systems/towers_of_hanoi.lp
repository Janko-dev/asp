
% define total timesteps
#const h = 7.

% define stacks and disks
stack(1..3).
disk(a; b; c).

% define size of disks (volume) used for the ordering
size(a, 1).
size(b, 2).
size(c, 3).

% initial state and goal state
init(loc(a, b); loc(b, c); loc(c, 1)).
goal(loc(a, b); loc(b, c); loc(c, 3)).

% start state
%   [ a ]
%  [  b  ]
% [   c   ] 
%  stack 1   stack 2   stack 3

% goal state
%                      [ a ]
%                     [  b  ]
%                    [   c   ] 
%  stack 1   stack 2   stack 3

% initialise holds/2 at time step 0
holds(L, 0) :- init(L).

% generate all possible modes X to Y, 
% where X is a disk and Y is either a disk or a stack
{ 
    occurs(move(X, Y), T): disk(X), disk(Y);
    occurs(move(X, Y), T): disk(X), stack(Y)
} = 1 :- T = 0..h-1.

% cannot move disk onto itself
:- occurs(move(X, X), T). 

% cannot move X onto Y if there is something on top of X
:- occurs(move(X, Y), T), holds(loc(_, X), T). 

% cannot move X to Y if X is already on Y
:- occurs(move(X, Y), T), holds(loc(X, Y), T).  

% derive next state based on transition
holds(loc(X, Y), T+1) :- occurs(move(X, Y), T).

% inertia: either maintain unchanged state in next time step 
% or do not derive it in next time step 
{ holds(loc(X, Y), T+1) } :- holds(loc(X, Y), T), T = 0..h-1.

% reject answer sets where X is on top of Y 
% and X is a larger disk than Y
:- holds(loc(X, Y), T), size(X, N1), size(Y, N2), N1 > N2.

% no two disks can be on top of the same Y
:- holds(loc(X, Y), T), holds(loc(X', Y), T), X != X'.

% at every time step, every disk must be in some state (location)
:- #count{ Y: holds(loc(X, Y), T) } != 1, disk(X), T = 0..h.

% reject models where goal was not reached at time h (at the end)
:- goal(L), not holds(L, h).

#show occurs/2.
