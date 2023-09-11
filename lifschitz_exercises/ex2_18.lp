
#const k = 12.
#const n = 10.

% In terms of prime logic program (examples/prime_numbers.lp)
% composite(N) :- N = 1..n, I = 2..N-1, N\I = 0.
% prime(N) :- N = 2..n, not composite(N).

% coprime(1).
% coprime(X) :- X = 1..n, prime(X), k\X != 0.

% In terms of coprime definition. 
% That is, any two numbers are coprime if the only positive integer that divides both of them is 1.
non_coprime(N) :- N = 1..n, I = 2..N, k \ I = 0, N\I=0.

coprime(N) :- N = 1..n, not non_coprime(N).

#show coprime/1.