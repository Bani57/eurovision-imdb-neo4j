SELECT CONCAT(D1.first_name,' ',D1.last_name) AS DIRECTOR1,CONCAT(D2.first_name,' ',D2.last_name) AS DIRECTOR2, COUNT(DISTINCT MD1.movie_id) AS NUM_MOVIES 
FROM IMDB.movies_directors MD1, IMDB.movies_directors MD2, IMDB.directors D1, IMDB.directors D2
WHERE MD1.director_id != MD2.director_id
AND MD1.movie_id = MD2.movie_id
AND D1.id = MD1.director_id
AND D2.id = MD2.director_Id
AND D1.last_name LIKE 'H%'
AND D2.last_name LIKE 'B%'
GROUP BY DIRECTOR1, DIRECTOR2
ORDER BY NUM_MOVIES DESC
LIMIT 1