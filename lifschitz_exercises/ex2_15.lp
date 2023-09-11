% define same_city/2 in terms of lives_in/2

lives_in(jan, beek). 
lives_in(ani, beek). 
lives_in(anna, sittard). 

same_city(X, Y) :- lives_in(X, C), lives_in(Y, C), X != Y.

#show same_city/2.