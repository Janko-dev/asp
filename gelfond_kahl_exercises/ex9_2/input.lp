% initial state
-holds(up(1), 0).
-holds(up(2), 0).
-holds(open, 0).

% goal definition
goal(I) :- holds(open, I).

#show occurs/2.
% #show holds/2.
% #show -holds/2.
% #show goal/1.