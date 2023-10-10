
% ------------------
% | dynamic system |
% ------------------
fluent(inertial, in_room).
fluent(inertial, locked).
fluent(inertial, has_key).
fluent(inertial, on(switch)).
fluent(inertial, ab(switch)).
fluent(inertial, ab(door)).
fluent(defined, lights_on).

action(agent, unlock).
action(agent, toggle(switch)).
action(agent, enter).
action(exogenous, break(switch)).
action(exogenous, break(power_line)).

#const n = 9.
step(0..n).

%%% Causal laws
% unlock causes -locked if locked, -ab(door)
-holds(locked, I+1) :- occurs(unlock, I), holds(locked, I), -holds(ab(door), I), I < n.

% toggle(switch) causes on(switch) if -on(switch)
holds(on(switch), I+1) :- occurs(toggle(switch), I), -holds(on(switch), I), I<n.
-holds(on(switch), I+1) :- occurs(toggle(switch), I), holds(on(switch), I), I<n.

% enter causes in_room if -locked, -in_room
holds(in_room, I+1) :- occurs(enter, I), -holds(locked, I), -holds(in_room, I), I<n.

% break(switch) causes ab(switch)
holds(ab(switch), I+1) :- occurs(break(switch), I), I<n.

% break(power_line) causes ab(switch)
holds(ab(switch), I+1) :- occurs(break(power_line), I), I<n.

%%% State constraints
% into_room if -locked_room, -dark_room, 
holds(lights_on, I) :- holds(on(switch), I), -holds(ab(switch), I), I<n. 

:- occurs(on(switch), I), -holds(in_room, I).

% inertia 
holds(F, I+1) :- fluent(inertial, F), holds(F, I), not -holds(F, I+1), I < n.
-holds(F, I+1) :- fluent(inertial, F), -holds(F, I), not holds(F, I+1), I < n.

% CWA for actions
-occurs(A, I) :- action(_, A), step(I), not occurs(A, I).

% CWA for defined fluents
-holds(F, I) :- fluent(defined, F), step(I), not holds(F, I). 

% -----------------
% | initial setup |
% -----------------
% -holds(in_room, 0).
% -holds(lights_on, 0).
% holds(locked, 0).
% -holds(on(switch), 0).
% -holds(ab(switch), 0).
% -holds(ab(door), 0).
% holds(has_key, 0).

% goal(I) :- holds(in_room, I), holds(lights_on, I), I<n.

% -------------------
% | planning module |
% -------------------
% success :- goal(I), I<=n.
% :- not success.

% {occurs(A, I) : action(agent, A) } = 1 :- step(I), not goal(I), I<n.

% #minimize{ 1, I : occurs(A, I) }.

% #show occurs/2.

% -----------
% | history |
% -----------

#const k = 4.

obs(in_room, false, 0).
obs(lights_on, false, 0).
obs(locked, true, 0).
obs(on(switch), false, 0).
obs(ab(switch), false, 0).
obs(ab(door), false, 0).
obs(has_key, true, 0).

hpd(unlock, 0).
hpd(enter, 1).
hpd(toggle(switch), 2).

obs(lights_on, false, 3).

% --------------------
% | test for symptom |
% ----------- --------
holds(F, 0) | -holds(F, 0) :- fluent(inertial, F).
occurs(A, I) :- hpd(A, I).
:- obs(F, true, I), -holds(F, I).
:- obs(F, false, I), holds(F, I).

% ------------
% | diagnose |
% ------------
{ occurs(A, I): action(exogenous, A) } :- step(I), I < k.

expl(A, I) :- action(exogenous, A), 
              occurs(A, I), 
              not hpd(A, I).

% reject answer sets where the same break action occurs after another break action
% i.e., something cannot break when it is already broken.
:- occurs(break(E), I), occurs(break(E), J), I < J.

% minimal explanation
#minimize{ 1, A, I : occurs(A, I), action(exogenous, A) }.

#show expl/2.