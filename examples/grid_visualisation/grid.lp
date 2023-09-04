
#const n = 10.

% checkerboard pattern
grid(R, C, (R + C)\2) :- R = 1..n, C = 1..n, 
    R/10 = 0, 
    C/10 = 0. 

#show grid/3.