% Color the edges of a graph such that no two incident edges have the same color.
% Two edges are incident if either one of the end-points is the same.
% e.g., for edges (a, b), (c, d), if a = c OR b = d, then edges are incident.  

vertex(a; b; c; d; e; f).

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

% undirected edges are symmetric
edge(X, Y) :- edge(Y, X).

% input color set
color(red; green; blue).

% for each edge, choose a color
{ edge(X, Y, C) : color(C) } = 1 :- edge(X, Y).

% uphold the symmetric property of undirected edges
:- edge(X, Y, C1), edge(Y, X, C2), C1 != C2.

% reject edges if their begin-points are the same, but their end-points are different 
:- edge(X, Y1, C), edge(X, Y2, C), Y1 != Y2.
% reject edges if their end-points are the same, but their begin-points are different
:- edge(X1, Y, C), edge(X2, Y, C), X1 != X2.

#show edge/3.