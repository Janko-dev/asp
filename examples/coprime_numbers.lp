
#const k = 12.
#const n = 10.

% composite(N) :- N = 1..n, I = 2..N-1, N\I = 0.

% prime(N) :- N = 2..n, not composite(N).

% coprime(1).
% coprime(X) :- X = 1..n, prime(X), k\X != 0.

non_coprime(N) :- N = 1..n, I = 2..N-1, N \ I = 0, k\N = 0.

coprime(N) :- N = 1..n, not non_coprime(N).

% #show coprime/1.