% find largest clique of graph

node(a; b; c; d; e; f).

edge(a, b).
edge(a, c).
edge(b, c).
edge(b, d).
edge(c, e).
edge(d, e).
edge(d, f).

edge(d, c).
edge(b, e).

%   /-- b -- d -- f
% a     | >< |
%   \-- c -- e

% create all possible subsets of nodes
{ in(X) : node(X) }.

% Only accept answer sets where all elements are 
% directly adjacent to each other
:- in(X), in(Y), not edge(X, Y), not edge(Y, X), X != Y.

#maximize{ 1, X : in(X) }.

#show in/1.