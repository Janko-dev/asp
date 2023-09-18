
cap(can1, 8).
cur(can1, 8).

cap(can2, 5).
cur(can2, 0).

cap(can3, 3).
cur(can3, 0).

move(can1, can2, 4).

new_cur(X, I-Z) :- cur(X, I), move(X, Y, Z).
new_cur(Y, I+Z) :- cur(Y, I), move(X, Y, Z).


#show new_cur/2.
