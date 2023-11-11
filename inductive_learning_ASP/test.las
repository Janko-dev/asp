
% background B
num(1).
num(2).
num(3).
num(4).

part(1).
part(2).

% search space SM
#modeha(set(var(t1), const(number))).
#constant(number, 1).
#constant(number, 2).

#modeb(num(var(t1))).
#modeb(part(var(t1))).
#modeb(set(var(t1))).
#modec(neq(var(t1),var(t2))).

% positive examples E+
#pos({set(1, 1), set(4, 1)}, {}).
#pos({set(2, 2), set(3, 2)}, {}).

% % negative examples E-
#neg({set(1, 1), set(2, 1), set(3, 1)}, {}).