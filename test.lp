
% #const r = 2.
% #const c = 2.

% rows(1..r).
% cols(1..c).

% states(blue; green).


% { cell(1..r, 1..c, S, t0): states(S) } = 2*r*c.

% { cell(R, C, S, t1): cell(R, C, S, t0) } :- S = green.

% #show cell/4.

