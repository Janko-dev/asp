% Traveling salesmen problem
% find shortest path that visits all cities exactly once

% define timesteps 1..n where n is the number of cities
n(1..4).
city(sittard; maastricht; heerlen; beek).

% define kilometres between each city
edge(sittard, heerlen, 20).
edge(beek, heerlen, 15).
edge(maastricht, heerlen, 20).
edge(beek, sittard, 10).
edge(maastricht, sittard, 25).
edge(beek, maastricht, 10).

% distance between cities is transitive
edge(X, Y, C) :- edge(Y, X, C).

% for each timestep, create answer sets for every possible city
{ path(C, N) : city(C) } = 1 :- n(N).

% reject answer sets where the same city occurs in different timesteps
:- path(C, N1), path(C, N2), N1 != N2.

% define cost as the sum of the distances
cost(X) :- X = #sum{ D, C1, C2 : edge(C1, C2, D), path(C1, N), path(C2, N+1) }.

% find model with minimal cost
% #minimize { X : cost(X) }.

#show path/2.
#show cost/1.

