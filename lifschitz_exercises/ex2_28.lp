% how many stable models will clingo find in the program:
% 1.    { p(1..10) }.
% 2.    :- p(2*X).

% The first line will produce all combinations of the set 
%     { p(1), p(2), p(3), p(4), p(5), 
%     p(6), p(7), p(8), p(9), p(10), }
% which are 2^10 = 1024 stable models.

% The second line will filter out those atoms that are even 
% due to the 2*X property. 
%     { p(1), p(3), p(5), p(7), p(9)}
% Since there are 5 atoms, of which each can be 
% either in the stable model or not, the total
% amount of stable models produced by clingo is 2^5 = 32.

{ p(1..10) }.
:- p(2*X).