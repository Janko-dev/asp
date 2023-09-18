
% shur numbers: a set X is called sum-free 
% if the sum of two elements of X never belongs to X.
#const n = 4.
#const k = 2.

% initialise all numbers
num(1..n).
part(1..k).

% for every number, create a subset of size 1 with choice 1..k partitions.
% total number of combinations is thus k^n, i.e., every number has k possible partitions.
{ set(X, K) : part(K) } = 1 :- num(X).

% not in answer set if sum of two set elements is also an element of set
:- set(X, K), set(Y, K), set(Z, K), Z = X + Y.

#show set/2.