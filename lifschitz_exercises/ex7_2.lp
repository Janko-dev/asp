% Given a set of predicates where(C, I), that denote class C is taught on floor I
% How many classes are taught on each floor. 
% number of floor is k

#const k = 5.

where(spanish, 1; math, 2; french, 5; economics, 2; art, 1; compsci, 3).

howmany(I, N) :- I = 1..k, N = #count{ C, I : where(C, I) }.

#show howmany/2.