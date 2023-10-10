% Explanation generation rule
{ occurs(A, I): action(exogenous, A) } :- step(I), I < n.

% if exogenous action is predicted to occur, 
% but there is no historical evidence of the action occurring 
expl(A, I) :- action(exogenous, A), 
              occurs(A, I), 
              not hpd(A, I).

#show expl/2.
#show holds/2.
#show -holds/2.

% % answer set 1:

% -holds(stale(bs),0) -holds(mixed(bs,lj),0) -holds(foam(bs,lj),0) 
% expl(went_stale,0) 
% holds(stale(bs),1) holds(mixed(bs,lj),1) -holds(foam(bs,lj),1) 


% % answer set 2:

% holds(stale(bs),0) -holds(mixed(bs,lj),0) -holds(foam(bs,lj),0)  
% holds(stale(bs),1) holds(mixed(bs,lj),1) -holds(foam(bs,lj),1) 


% % answer set 3:

% holds(stale(bs),0) -holds(mixed(bs,lj),0) -holds(foam(bs,lj),0) 
% expl(went_stale,0) 
% holds(stale(bs),1) holds(mixed(bs,lj),1) -holds(foam(bs,lj),1)  
