SELECT CONCAT(A.first_name,' ',A.last_name) AS ACTOR,CONCAT(D.first_name,' ',D.last_name) AS DIRECTOR,COUNT(R.movie_id) AS NUM_MOVIES
FROM IMDB.actors A, IMDB.roles R, IMDB.movies_directors MD, IMDB.directors D
WHERE A.id = R.actor_id
AND R.movie_id = MD.movie_id
AND MD.director_id = D.id
AND A.first_name = 'Jack'
AND D.first_name != 'Unknown'
GROUP BY ACTOR, DIRECTOR
ORDER BY NUM_MOVIES DESC
LIMIT 1