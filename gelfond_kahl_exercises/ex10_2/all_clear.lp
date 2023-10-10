% find out whether a system encoding and a history 
% is a symptom

holds(F, 0) | -holds(F, 0) :- fluent(inertial, F).
occurs(A, I) :- hpd(A, I).
:- obs(F, true, I), -holds(F, I).
:- obs(F, false, I), holds(F, I).