
n(1..3).

% list(N, null) :- list(N, list(M)).
list(N-1, list(N, list(M, null))) :- list(N, list(M, null)), n(N-1).
list(N, list(N+1, null)) :- n(N), n(N+1).



