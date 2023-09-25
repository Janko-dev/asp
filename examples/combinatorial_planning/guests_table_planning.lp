
% number of tables
#const t = 3. 
% number of guests
#const g = 4.

% guests who like/dislike each other
likes(1, 2; 3, 4).
dislikes(2, 3; 1, 3).

guest(1..g).
table(1..t).

% Generate all possible combinations of guest G at table T 
{ at(G, T): table(T) } = 1 :- guest(G).

% filter out the guests positioned at two different tables
:- at(G, T1), at(G, T2), T1 != T2.

% filter out guests seated at the same table (T1 = T2) who dislike each other
:- dislikes(G1, G2), at(G1, T1), at(G2, T2), T1 = T2.

% filter out guests seated at different tables who like each other
:- likes(G1, G2), at(G1, T1), at(G2, T2), T1 != T2.

#show at/2.
