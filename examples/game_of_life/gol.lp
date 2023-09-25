nghbs(Down+Up+Left+Right+RightUp+RightDown+LeftUp+LeftDown, R, C) :- 
    old_grid(R+1, C, Down),
    old_grid(R-1, C, Up),
    old_grid(R, C-1, Left),
    old_grid(R, C+1, Right),
    old_grid(R-1, C+1, RightUp),
    old_grid(R+1, C+1, RightDown),
    old_grid(R-1, C-1, LeftUp),
    old_grid(R+1, C-1, LeftDown).

% Any live cell with fewer than two live neighbours dies, as if by underpopulation.
grid_aux(R, C, 0) :- old_grid(R, C, 1),
                 nghbs(N, R, C),
                 N < 2.

% Any live cell with two or three live neighbours lives on to the next generation.
grid_aux(R, C, 1) :- old_grid(R, C, 1),
                 nghbs(N, R, C),
                 N = 2.

grid_aux(R, C, 1) :- old_grid(R, C, 1),
                 nghbs(N, R, C),
                 N = 3.

% Any live cell with more than three live neighbours dies, as if by overpopulation.
grid_aux(R, C, 0) :- old_grid(R, C, 1),
                 nghbs(N, R, C),
                 N > 3.

% Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
grid_aux(R, C, 1) :- old_grid(R, C, 0),
                 nghbs(N, R, C),
                 N = 3.

% Otherwise copy from old_grid to grid_new
grid_aux(R, C, X) :- old_grid(R, C, X), not grid(R, C, _).

grid(R, C, X) :- old_grid(R, C, X), not grid_aux(R, C, _).
grid(R, C, X) :- grid_aux(R, C, X).


#show grid/3.