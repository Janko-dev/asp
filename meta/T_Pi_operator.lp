% Very basic implementation of the T_{\Pi} operator defined on 
% definite programs \Pi
%   T_{\Pi}(A) = {p_h : p_h <- B \in \Pi, B \subseteq A}

% rule(H, B) where H is a single atom and body is a tuple 
% (currently only a 2-tuple) 
rule(p, ()).
rule(q, (p)).
rule(r, (p, q)).
rule(y, (x)).

% derive the dependency graph 
% from which the facts can be derived
dep(X, ()) :- rule(X, ()).
dep(X, Z) :- rule(X, (Y)), rule((Y), Z).
dep(X, Z) :- rule(X, (Y1, _)), dep(Y1, Z).
dep(X, Z) :- rule(X, (_, Y1)), dep(Y2, Z).

t(X) :- dep(X, ()).

#show t/1.