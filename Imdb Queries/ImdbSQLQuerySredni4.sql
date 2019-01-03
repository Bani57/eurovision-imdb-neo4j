SELECT D.*
FROM IMDB.directors D
WHERE D.first_name LIKE 'M%'
AND EXISTS (
SELECT *
FROM IMDB.movies_directors MD, IMDB.movies M, IMDB.roles R, IMDB.actors A
WHERE MD.director_id = D.id
AND M.id = MD.movie_id
AND R.movie_id = MD.movie_id
AND A.id = R.actor_id
AND M.year BETWEEN 1980 AND 1990
AND CONCAT(A.first_name,' ',A.last_name) = 'Winona Ryder'
)
AND NOT EXISTS (
SELECT *
FROM IMDB.movies_directors MD, IMDB.movies M, IMDB.roles R, IMDB.actors A
WHERE MD.director_id = D.id
AND M.id = MD.movie_id
AND R.movie_id = MD.movie_id
AND A.id = R.actor_id
AND M.year BETWEEN 1980 AND 1990
AND CONCAT(A.first_name,' ',A.last_name) = 'Nicolas Cage'
)