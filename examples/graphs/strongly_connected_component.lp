% Find all strongly connected components of a directed graph
% A strongly connected component is a set of nodes such that
% there is a directed path between each pair of nodes.
node(a; b; c; d).

edge(a, b).
edge(b, c).
edge(c, b).
edge(c, d).
edge(d, b).

% a -> b -> c -> d
%      ^    |    | 
%      \---------/

% generate powerset of nodes (excluding emptyset)
1 { in(X) : node(X) }.

% recursive definition of a path
path(X, Y) :- edge(X, Y). 
path(X, Y) :- path(X, Z), path(Z, Y).

% for every node X, Y, there must be a directed path
:- in(X), in(Y), not path(X, Y), X != Y.

#show in/1.


