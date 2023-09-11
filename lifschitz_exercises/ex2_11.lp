% a) Reproduce p(0,1) p(1,-1) p(2,1) p(3,-1) p(4,1) without pooling
p(C, (-1)**C) :- C = 0..4.

% b) Reproduce 
% p(1,1) 
% p(2,1) p(2,2)
% p(3,1) p(3,2) p(3,3)
% p(4,1) p(4,2) p(4,3) p(4,4)
% without pooling

p(C, D) :- C = 1..4, D = 1..4, D <= C.