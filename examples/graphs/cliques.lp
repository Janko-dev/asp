% find cliques of size n
#const n = 3.

node(a; b; c; d; e; f).

edge(a, b).
edge(b, e).
edge(a, d).
edge(e, d).
edge(c, a).
edge(b, c).
edge(f, c).
edge(f, e).
edge(d, f).

% create all possible subsets of nodes of size n
{ in(X) : node(X) } = n.

% Only accept answer sets where all elements are 
% directly adjacent to each other
:- in(X), in(Y), not edge(X, Y), not edge(Y, X), X != Y.

#show in/1.