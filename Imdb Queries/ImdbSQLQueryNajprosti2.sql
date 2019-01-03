SELECT CONCAT(A.first_name,' ',A.last_name) AS ACTOR, M.name AS MOVIE, COUNT(DISTINCT R.role) AS NUM_ROLES 
FROM IMDB.actors A, IMDB.roles R, IMDB.movies M
WHERE R.actor_id = A.id
AND M.id = R.movie_id
AND A.first_name = 'John'
GROUP BY ACTOR, MOVIE
HAVING NUM_ROLES > 1
ORDER BY NUM_ROLES DESC