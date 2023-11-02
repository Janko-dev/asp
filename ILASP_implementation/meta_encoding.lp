%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T_{meta}^n encoding with n = 2 of:
% - B = {q <- r}
% - E+ = {{p}, {q}}
% - E- = {{p, q}}
% - SM = {
%     p;
%     r;
%     p <- r;
%     p <- not r;
%     r <- not p;
% }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program meta(n).
% meta(B)
e(q, X) :- e(r, X), ex(X).

% meta(SM)
e(p, X) :- active(r1), ex(X).
e(r, X) :- active(r2), ex(X).
e(p, X) :- e(r, X), active(r3), ex(X).
e(p, X) :- not e(r, X), active(r4), ex(X).
e(r, X) :- not e(p, X), active(r5), ex(X).

% meta(E+)
ex(e1).
ex(e2).
:- not example_covered(e1).
:- not example_covered(e2).
example_covered(e1) :- e(p, e1).
example_covered(e2) :- e(q, e2).

% meta(E-)
violating :- e(p, negative), e(q, negative).

% meta(Aux, n)
length(r1, 1).
length(r2, 1).
length(r3, 2).
length(r4, 2).
length(r5, 2).

:- #sum{ X, R : length(R, X), active(R) } != n.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate the powerset of active rules based on rule ID 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program generate.
rule_id(r1; r2; r3; r4; r5).

{active(X) : rule_id(X)}.

#show.
#show active/1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% used to derive violating solutions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program violations.
:- not violating.
ex(negative).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% example procedure.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% iter 1 with n = 2:
% :- active(r1), active(r2). 
% yiels UNSAT

% iter 2 with n = 3:
% :- active(r2), active(r3).
% yiels UNSAT

% iter 3 with n = 4:
% :- active(r1), active(r2), active(r4).
% :- active(r1), active(r2), active(r5).
% :- active(r1), active(r2), active(r3).
% yields SAT with answer set: {active(r4), active(r5)}
% in other words, the hypothesis H is the program:
%   p :- not r.
%   r :- not p.
% which together with the background B = {q :- r} gives
% answer sets that extends each positive example, and 
% never extend any negative example. 