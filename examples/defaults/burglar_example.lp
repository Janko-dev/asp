
% Nami and John are burglars
burglar(nami).
burglar(john).

% Arlong is a bad person
bad(arlong).

% Nami stole from Arlong
stole(nami, arlong).

% strong exception:
% X is not a bad person if X stole from a bad person Y.
-bad(X) :- burglar(X),
           bad(Y),
           stole(X, Y), 
           X != Y.

% weak exception:
% X is abnormal with respect to bad/1
% if it is not enough evidence to believe that X did not steal from Y
ab(default_bad(X)) :- burglar(X), 
                      bad(Y),
                      not -stole(X, Y), 
                      X != Y.

% If either strong or weak exception occurs, 
% it is not possible to entail bad(X)
bad(X) :- burglar(X),
          not ab(default_bad(X)),
          not -bad(X).

#show -bad/1.
#show bad/1.