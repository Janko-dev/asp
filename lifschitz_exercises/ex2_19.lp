% generate list of integers that cannot be represented as the sum of three complete squares. 
% for example, 7 and 15 cannot be represented with the sum of three positive integers.
% 7 = 2^2 + 1^2 + 1^2 + 1^2;

#const n = 15.

three(N) :- N = 1..n, 
    S1 = 0..n,
    S2 = 0..n,
    S3 = 0..n,
    N = S1**2 + S2**2 + S3**2.

more_than_three(N) :- N = 1..n, not three(N).

#show more_than_three/1.