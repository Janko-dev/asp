% Recursive factorial definition in terms of generating the set {(0, 0!), (1, 1!), ..., (n, n!)}
% Note that fac/1 is in the stable model iff fac/2 generates the correct set of factorials 

% Generating the set of factorials is defined by the base case for (0, 0!) 
% and then two propositions that need to be true.
% 1. the value of N (which starts at 0) needs to be less than n
% 2. the fac/2 is recursively called which accumulates the factors untill proposition 1 is false. 

#const n = 4.

fac(0, 1).
fac(N+1, F*(N+1)) :- fac(N, F), N < n.

fac(N) :- fac(N, n).

#show fac/1.