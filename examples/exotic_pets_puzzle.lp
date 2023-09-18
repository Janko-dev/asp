first(abner; chuck; duane; bruce).
last(engels; foster; gunter; havely).

pet(iguana; jackal; cobra; llama).

{ full_name(F, L) : first(F) } = 1 :- last(L).

{ owns(full_name(F, L), P) : full_name(F, L) } = 1 :- pet(P).

:- owns(full_name(F, L), P1), owns(full_name(F, L), P2), P1 != P2.

:- owns(full_name(F, L1), _), owns(full_name(F, L2), _), L1 != L2.
:- owns(full_name(F1, L), _), owns(full_name(F2, L), _), F1 != F2.

% 1. abner is not mr foster and not mr engels
:- owns(full_name(abner, foster), P).
:- owns(full_name(abner, engels), P).

% 2. iguana is not owned by either chuck or duane
:- owns(full_name(chuck, L), iguana).
:- owns(full_name(duane, L), iguana).

% 3. neither the jackal nor the cobra are owned by mr foster
:- owns(full_name(F, foster), jackal).
:- owns(full_name(F, foster), cobra).

% 4. llama does not belong to duane
:- owns(full_name(duane, L), llama).
% duane's pet's name is waggles, whereas mr engels' pet name is sparky
:- owns(full_name(duane, engels), P).

% 5. abner does not own cobra, and is not mr gunter
:- owns(full_name(abner, L), cobra).
:- owns(full_name(abner, gunter), P).

% 6. bruce is not mr foster
:- owns(full_name(bruce, foster), P).

% 7. mr havely does not own the iguana
:- owns(full_name(F, havely), iguana).

#show owns/2.