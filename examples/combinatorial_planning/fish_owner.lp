% Who owns the fish? puzzle

% there are 5 distinct houses with different colors
n(1..5).
house(red; green; white; yellow; blue).

% there are 5 distinct nationalities
nat(brit; swede; dane; norwegian; german).

% there are 5 distinct pets
pet(dog; cat; horse; bird; fish).

% there are 5 distinct beverages
beverage(tea; coffee; milk; beer; water).

% there are 5 distinct drinking beverages
brand(pall_mall; dunhill; blend; bluemaster; princess).

% for each house, derive all possible combinations of nat, pet, bev, house, cig brand
% i.e., 5^5^5 (very big number)
{comb(N, Nat, Pet, Bev, Hous, Cig) : nat(Nat), pet(Pet), beverage(Bev), house(Hous), brand(Cig) } = 1 :- n(N).

% reject answer sets two different houses have the same property
:- comb(N1, Nat, _, _, _, _), comb(N2, Nat, _, _, _, _), N1 != N2. 
:- comb(N1, _, Pet, _, _, _), comb(N2, _, Pet, _, _, _), N1 != N2. 
:- comb(N1, _, _, Bev, _, _), comb(N2, _, _, Bev, _, _), N1 != N2. 
:- comb(N1, _, _, _, Hous, _), comb(N2, _, _, _, Hous, _), N1 != N2. 
:- comb(N1, _, _, _, _, Cig), comb(N2, _, _, _, _, Cig), N1 != N2. 

% the brit lives in a red house
:- not comb(_, brit, _, _, red, _).

% the swede has a dog
:- not comb(_, swede, dog, _, _, _).

% the dane drinks tea
:- not comb(_, dane, _, tea, _, _).

% the green house is on the left of the white house
:- comb(N, _, _, _, white, _), comb(N-1, _, _, _, X, _), X != green.

% person living in the green house drinks coffee
:- not comb(_, _, _, coffee, green, _).

% person who smokes pall mall has birds
:- not comb(_, _, bird, _, _, pall_mall).

% person living in yellow house smokes dunhill 
:- not comb(_, _, _, _, yellow, dunhill).

% person living in the center drinks milk
:- not comb(3, _, _, milk, _, _).

% the first house is norwegian
:- not comb(1, norwegian, _, _, _, _).

% person smoking blend has a neighbour with a cat
:- comb(N1, _, _, _, _, blend), comb(N2, _, cat, _, _, _), |N1-N2| != 1.

% person with a horse has a neighbour who smokes dunhill 
:- comb(N1, _, horse, _, _, _), comb(N2, _, _, _, _, dunhill), |N1-N2| != 1.

% person smoking blue master drinks beer
:- not comb(_, _, _, beer, _, bluemaster).

% the german smokes princess
:- not comb(_, german, _, _, _, princess).

% the neighbour of the norwegian lives in a blue house
:- comb(N1, norwegian, _, _, _, _), comb(N2, _, _, _, blue, _), |N1-N2| != 1.

% neighbour of person smoking blend drinks water
:- comb(N1, _, _, _, _, blend), comb(N2, _, _, water, _, _), |N1-N2| != 1.

% the person with the fish is...
owns_fish(N, Nat, fish, Bev, Hous, Cig) :- comb(N, Nat, fish, Bev, Hous, Cig).

#show owns_fish/6.