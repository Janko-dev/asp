% Film and actor database
film(interstellar).
film(fightclub).
film(snatch).

actor(brad_pitt).
actor(jason_statham).
actor(anne_hathaway).
actor(matt_damon).

% Relationship between actor and film
plays_in(anne_hathaway, interstellar).
plays_in(matt_damon, interstellar).
plays_in(brad_pitt, fightclub).
plays_in(brad_pitt, snatch).
plays_in(jason_statham, snatch).

% X and Y play in the same movie M
same_film(X, Y, M) :- plays_in(X, M), 
                      plays_in(Y, M), 
                      X != Y, 
                      not same_film(Y, X, M).

% X does not play in movie M
-plays_in(X, M) :- actor(X), 
                   film(M), 
                   not plays_in(X, M).

% Genres
genre(drama; science_fiction; action; thriller).

% Temporary relationship between film and genre
temp_film_genre(interstellar, science_fiction).
temp_film_genre(fightclub, action).
% genre(snatch, action).

% Normally, a film M has a corresponding genre, 
% but if there is no genre assigned, then the default 
% genre should be "action". 
film_genre(M, G) :- temp_film_genre(M, G).
film_genre(M, action) :- film(M), not temp_film_genre(M, _).

% #show same_film/3.
% #show -plays_in/2.
% #show plays_in/2.
#show film_genre/2.
