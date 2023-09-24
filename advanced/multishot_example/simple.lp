
% rules without #program directive are 
% considered in the base program.
% The base program is analogous to 
% main.
a(1).

% subprogram named 'acid' with a single program argument 'k'.
% program arguments are similar to #const directives
#program acid(k).

% External rule that gets grounded as usual.
% However, its truth value is default set to false.
#external d(X, k) : c(X, k).

% b(k) is a fact
b(k).
% since the subprogram does not contain a(X)
% this rule is ignored
c(X, k) :- a(X).

% if external value for d(X, k) is defined 
% and set to true, then e(X, k) is derived 
e(X, k) :- d(X, k).

% base program that takes top-level rules into account
#program base.
a(2).
