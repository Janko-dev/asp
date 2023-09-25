% Find vertex cover of graph.
% vertex cover is the set of vertices such that the set 
% covers every edge. 
% Find the vertex cover with respect to a set size n
#const n = 4.

node(a; b; c; d; e; f).

edge(a, b).
edge(a, c).
edge(b, c).
edge(b, d).
edge(c, e).
edge(d, e).
edge(d, f).

%   /-- b -- d -- f
% a     |    |
%   \-- c -- e

% generate all possible node combinations of size n
{ in(X) : node(X) } = n.

% derive the covered edges based on the n-size subsets of nodes
covered(X, Y) :- in(X), edge(X, Y).
covered(X, Y) :- in(Y), edge(X, Y).

% reject answer sets with an edge that is not covered
:- edge(X, Y), not covered(X, Y).

#show in/1.