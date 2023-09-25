% define prime numbers if the number is not a composite number. 
% i.e., a number C is composite if dividing it by its preceding numbers 
% results in a remainder of 0. 
% A prime number is then any number that is not composite.

#const upper_bound = 20.

composite(N) :- N = 1..upper_bound, I = 2..N-1, N\I = 0.

prime(N) :- N = 2..upper_bound, not composite(N).

#show prime/1.