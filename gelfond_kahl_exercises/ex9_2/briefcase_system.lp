% time step
#const n = 1.
step(0..n).

% sort "clasp" over {1, 2}
clasp(1; 2).

% inertial fluent over sort clasp and defined fluent open
fluent(inertial, up(C)) :- clasp(C).
fluent(defined, open).

% toggle action over sort clasp
action(toggle(C)) :- clasp(C).


% causal law: toggle(C) causes up(C) if -up(C)
holds(up(C), I+1) :- occurs(toggle(C), I), 
                     -holds(up(C), I),
                     I < n.

% causal law: toggle(C) causes -up(C) if up(C)
-holds(up(C), I+1) :- occurs(toggle(C), I), 
                      holds(up(C), I),
                      I < n.

% state constraint: open if up(1), up(2)
holds(open, I) :- holds(up(1), I), holds(up(2), I).

% CWA for defined fluents
-holds(F, I) :- fluent(defined, F),
                not holds(F, I),
                step(I).

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
-occurs(A, I) :- action(A), step(I),
                 not occurs(A, I).