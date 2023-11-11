% A company X controls another company Y if X directly or indirectly controls more than 50% of the shares of Y.
% Aggregate in rule is recursive because X can control another company indirectly, resulting in the recursive derivation of controls/2. 

% c1 owns 
% - c2 directly (60%)
% - c3 directly (20%) and indirectly through c2 (35%)
% - c4 indirectly through c3 (51%)

company(c1;c2;c3;c4).
owns(c1, c2, 60).
owns(c1, c3, 20).
owns(c2, c3, 35).
owns(c3, c4, 51).

controls(X, Y) :- 
    company(X), company(Y), X != Y,
    #sum{
        S: owns(X, Y, S); 
        S, Z : controls(X, Z), owns(Z, Y, S)
    } > 50.
    
#show controls/2.