#const n = 10.

% Checkerboard patten
% old_grid(R, C, (R + C)\2) :- R = 1..n, C = 1..n, 
%     R/10 = 0, 
%     C/10 = 0. 

% glider setup
old_grid(3, 2, 1).
old_grid(4, 3, 1).
old_grid(4, 4, 1).
old_grid(3, 4, 1).
old_grid(2, 4, 1).

% default everything is 0
old_grid(R, C, 0) :- R = 1..n, C = 1..n, not old_grid(R, C, 1).

#show old_grid/3.