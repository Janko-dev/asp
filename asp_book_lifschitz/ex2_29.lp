
% The following logic program uses an anonymous variable. 

% To explain why the stable model for this program is
% q(2), p(1, 1), we can start by including p(1, 1) in the answer set
% because it is a given atom fact.

% Then, in the rule, we start with X set to 1 and can replace p(X, _) with
% p(1, 1) due to the provided atom. The "not" operator makes this conclusion false
% which means that q(1) is not in the stable model.

% Thereafter, X is set to 2 and we replace p(X, _) with p(2, _).
% notice how there is no atom in our evidence set that can be matched with p(2, _).
% Thus, this predicate is false. However, the "not" makes this predicate true
% by which q(2) is established. 

p(1, 1).
q(X) :- X = 1..2, not p(X, _).