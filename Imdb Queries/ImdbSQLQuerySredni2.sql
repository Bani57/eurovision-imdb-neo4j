SELECT CONCAT(D.first_name,' ', D.last_name) AS DIRECTOR, COUNT(DISTINCT actor_id) AS NUM_ACTORS
FROM IMDB.directors D, IMDB.movies_directors MD, IMDB.directors_genres DG, IMDB.roles R
WHERE MD.director_id = D.id
AND DG.director_id = D.id
AND R.movie_id = MD.movie_id
AND DG.genre = 'Action'
AND DG.prob >= 0.9
AND D.first_name != 'Unknown'
GROUP BY DIRECTOR
HAVING NUM_ACTORS > 100
ORDER BY NUM_ACTORS DESC