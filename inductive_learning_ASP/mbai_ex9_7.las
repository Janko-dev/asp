% background B
p :- q.

% search space SM
2 ~ :- p, q.
2 ~ q :- not r.
3 ~ q :- p, not r.
2 ~ r :- not q.
2 ~ r :- p.
2 ~ p :- r.

% positive examples E+
#pos({r}, {}).
#pos({p}, {}).

% negative examples E-
#neg({r, p}, {}).

% q :- not r.
% r :- not q.


% #pos({r},{p}).
% #neg({r,p},{}).
% p:-q.
% 2 ~ :- p,q.
% 1 ~ q:- not r.
% 2 ~ q:- p, not r.
% 1 ~ r:- not q.
% 1 ~ r:- p.
% 1 ~ p:- r.

% r :- not q.
