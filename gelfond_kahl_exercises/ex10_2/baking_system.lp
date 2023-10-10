ingredient(bs; lj).

fluent(inertial, mixed(bs, lj)).
fluent(inertial, stale(bs)).
fluent(defined, foam(bs, lj)).

action(agent, mix).
action(exogenous, went_stale).

#const n = 1.
step(0..n).

% causal law: mix causes mixed(bs, lj)
holds(mixed(bs, lj), I+1) :- occurs(mix, I).

% causal law: went_stale causes stale(bs)
holds(stale(bs), I+1) :- occurs(went_stale, I).

% state constraint: foam(bs, lj) if mixed(bs, lj), -stale(bs)
holds(foam(bs, lj), I) :- holds(mixed(bs, lj), I), -holds(stale(bs), I).

% inertia axiom
holds(F, I+1) :- holds(F, I), not -holds(F, I+1), I < n.

-holds(F, I+1) :- -holds(F, I), not holds(F, I+1), I < n.

% CWA for actions
-occurs(A, I) :- action(_, A), step(I), not occurs(A, I).

% CWA for defined fluents
-holds(F, I) :- fluent(defined, F), step(I), not holds(F, I). 

% #show holds/2.
% #show -holds/2.
% #show occurs/2.
