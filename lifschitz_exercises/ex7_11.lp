% Knapsack problem: Given a set of items, their weights, 
% volumes, and values, compute the most optimal subset 
% of items, such that the highest combined value is
% achieved. 

% initialise 
weight(a, 12; b, 1; c, 4; d, 2; e, 1).
volume(a, 4; b, 3; c, 2; d, 7; e, 2).
value(a, 4; b, 2; c, 10; d, 2; e, 1).

#const maxweight = 15.
#const maxvolume = 12.

% derive the maximum of weight, volume
total_max_bound(M) :- M = #max{ maxweight; maxvolume }.

% generate all subsets of items, and the amount of copies C
{ sack(I, C): C = 1..M, total_max_bound(M) } :- weight(I, W).

% an item cannot be twice in the sack with different copy amounts
:- sack(I, C1), sack(I, C2), C1 != C2. 

% if the weight/volume of the subset of items exceeds the 
% maxweight/maxvolume, reject the answer set. 
:- #sum{ W*C, I : sack(I, C), weight(I, W) } > maxweight.
:- #sum{ V*C, I : sack(I, C), volume(I, V) } > maxvolume.

% maximize with respect to the value of the items times the
% amount of copies of the items
#maximize{V*C, I : sack(I, C), value(I, V)}.

#show sack/2.