% Find vertex with highest number of ancestors in graph

vertex(a; b; c; d; e; f).
edge(a, b; a, c; b, c; b, d; c, e; d, e; d, f).

%   /--> b --> d --> f
% a      |     |
%  \     V     V
%   \--> c --> e

% we consider every vertex as an answer set 
{ in(X) : vertex(X) } = 1.

% derive all ancestors of vertices
% Y is ancestor of X
ancestor(X, Y) :- vertex(X), edge(Y, X).
ancestor(X, Y) :- vertex(X), ancestor(X, Z), ancestor(Z, Y).

% count ancestors for each specific vertex (in/1 answer set)
ancestor_count(X, N) :- in(X), N = #count{ X, Y : ancestor(X, Y) }.

% optimize to find vertex with largest ancestry
#maximize{ N, X : ancestor_count(X, N) }.

#show ancestor_count/2.