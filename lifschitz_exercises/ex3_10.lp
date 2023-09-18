% Partition subsets that do not contain arithmetic progression of 3
% example {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, n = 10, k = 4.
% p1: { 1, 5, 3, 7 }
% p2: { 4, 2, 6 } 
% p3: { 8, 9 } 
% p4: { 10 }

#const n = 5.
#const k = 2.

% initialise all numbers
num(1..n).
part(1..k).

% for every number, create a subset of size 1 with choice 1..k partitions.
% total number of combinations is thus k^n, i.e., every number has k possible partitions.
{ set(X, K) : part(K) } = 1 :- num(X).

% if two numbers X and Y from the same set K follow each other 
% and have an absolute difference of 3, then they cannot be an answer set 
:- set(X, K), set(Y, K), X < Y, |X-Y| = 3.

#show set/2.