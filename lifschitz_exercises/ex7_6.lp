% a magic square is a n by n square filled with 
% all numbers from 1..n^2. Furthermore, the sum
% over the rows, sum over the columns, and the 
% sum over both diagonals must be equal. This 
% sum is called the magic number, which equals
% (n^3 + n)/2. 

% dimension of square
#const n = 3.
% corresponsing magic number
#const magic = (n**3+n)/2.

row(1..n).
col(1..n).

% derive all possible values for all possible 
% cells in the grid
{ m(R, C, 1..n*n) } = 1 :- row(R), col(C).

% ensure that every number is present in the square
:- not m(_, _, N), N = 1..n*n.

% reject model if sum over columns is not equal to magic number
:- col(C), magic != #sum { N, R, C : m(R, C, N) }.

% reject model if sum over rows is not equal to magic number
:- row(R), magic != #sum { N, R, C : m(R, C, N) }.

% reject model if sum over left top to right bottom diagonal
% is not equal to magic number
:- magic != #sum { N, R : m(R, R, N) }.

% reject model if sum over left bottom to right top diagonal
% is not equal to magic number
:- magic != #sum { N, R : m(R, n+1-R, N) }.

#show m/3. 