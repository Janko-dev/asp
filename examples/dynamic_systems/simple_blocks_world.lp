
% define objects in the domain 
block(a; b; c).
big_block(d; e).

% derive all possible locations (including the table t)
location(X) :- block(X).
location(X) :- big_block(X).
location(t).

% derive fixed time steps
#const n = 3.
step(0..n).

% "block B is on location L" is a property that changes with time
% i.e., is a fluent
fluent(on(B, L)) :- block(B), location(L).
fluent(on(B, L)) :- big_block(B), location(L).

% "put block B on location L" is a possible action, 
% provided we do not put a block onto itself.
action(put(B, L)) :- block(B), location(L), B != L.
action(put(B, L)) :- big_block(B), location(L), B != L.

% initial configuration
%          [a]
% [  d  ]  [b]  [c]   
% ---------------

holds(on(d, t), 0).
holds(on(a, b), 0).
holds(on(b, t), 0).
holds(on(c, t), 0).


% CWA
-holds(on(B, L), 0) :- block(B), location(L),
                       not holds(on(B, L), 0).

-holds(on(B, L), 0) :- big_block(B), location(L),
                       not holds(on(B, L), 0).

% causal law: if action occured, then hold state in next step
holds(on(B, L), I+1) :- occurs(put(B, L), I), I < n.

% No block occupies more than one location
-holds(on(B, L2), I) :- holds(on(B, L1), I),
                        location(L2),
                        L1 != L2.

% No block can support more than one block directly on top
-holds(on(B2, B), I) :- block(B),
                        holds(on(B1, B), I),
                        block(B2),
                        B1 != B2.

-holds(on(B3, B), I) :- big_block(B),
                        holds(on(B1, B), I),
                        holds(on(B2, B), I),
                        block(B1),
                        block(B2),
                        block(B3),
                        B1 != B2,
                        B1 != B3, 
                        B2 != B3.

% inertia
holds(F, I+1) :- holds(F, I),
                  not -holds(F, I+1),
                  I < n.

-holds(F, I+1) :- -holds(F, I),
                  not holds(F, I+1),
                  I < n.

% executability constraint
-occurs(put(B, L), I) :- location(L), 
                         holds(on(B1, B), I).

-occurs(put(B1, B), I) :- block(B1),
                          block(B),
                          holds(on(B2, B), I).

-occurs(put(B3, B), I) :- big_block(B),
                          holds(on(B1, B), I),
                          holds(on(B2, B), I),
                          block(B1),
                          block(B2),
                          block(B3),
                          B1 != B2.

% actions:
% block a to d
% block c to d
occurs(put(a, d), 0).
occurs(put(c, d), 1).

% prediction after actions
% [a] [c]
% [  d  ]  [b]   
% -----------------

#show holds/2.