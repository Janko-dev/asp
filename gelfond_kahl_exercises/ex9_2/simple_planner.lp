
% if goal was reached, derive success
success :- goal(I),
           I <= n.

% only keep successful answer sets solutions
:- not success.

% for each step, choose an action
{occurs(A, I) : action(A)} = 1 :- step(I), not goal(I), I < n.

#minimize{1, I : occurs(A, I)}.