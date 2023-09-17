% Number of chairs and guests
#const n = 6.

% Which guest likes/dislikes another guest
likes(1, 2; 3, 4).
dislikes(2, 3; 1, 3).

guest(1..n).
chair(1..n).

% Generate all possible combinations of guest G at chair C 
{ seat(G, C): guest(G) } = 1 :- chair(C).

% A guest G cannot sit in two different chairs (these seats are ignored)
:- seat(G, C1), seat(G, C2), C1 != C2.

% if G1 dislikes G2 and they are seated next to each other, then reject these answer sets
:- dislikes(G1, G2), seat(G1, C1), seat(G2, C2), |C1-C2| = 1.

% if G1 likes G2 and they are not directly seated next to each other, then reject these answer sets
:- likes(G1, G2), seat(G1, C1), seat(G2, C2), |C1-C2| != 1.

#show seat/2.

