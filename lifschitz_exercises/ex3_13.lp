% Color every node such that two adjacent nodes do not have the same color.
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

% input color set
color(red; green; blue).

% for each node, choose from color set
{ color(X, C) : color(C) } = 1 :- node(X).

% reject answer sets if two nodes have the same color
% and there is a direct edge between them
:- color(X, C), color(Y, C), edge(X, Y).

#show color/2.