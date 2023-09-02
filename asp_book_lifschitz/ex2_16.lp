% define older/2 in terms of age/2

age(jan, 24). 
age(anna, 24). 
age(ani, 20).

older(X, Y) :- age(X, A1), age(Y, A2), X != Y, A1 > A2.

#show older/2.