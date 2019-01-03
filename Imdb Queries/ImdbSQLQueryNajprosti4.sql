SELECT CONCAT(A.first_name,' ',A.last_name) AS ACTOR
FROM IMDB.actors A
WHERE EXISTS (
SELECT *
FROM IMDB.roles R, IMDB.movies_genres MG
WHERE R.actor_id = A.id
AND MG.movie_id = R.movie_id
AND R.role IN ('Himself','Herself')
AND MG.genre NOT IN ('Documentary','Short')
)
