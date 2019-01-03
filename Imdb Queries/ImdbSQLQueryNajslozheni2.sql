SELECT CONCAT(D.first_name,' ',D.last_name) AS DIRECTOR,
MAX(M.rank)
/(
SELECT MAX(M.rank)
FROM IMDB.movies M, IMDB.directors D, IMDB.movies_directors MD
WHERE M.id = MD.movie_id
AND M.rank != '\N'
AND MD.director_id = D.id
AND D.last_name = 'Manchevski'
) AS MAX_RANK
FROM IMDB.directors D, IMDB.movies_directors MD, IMDB.movies_genres MG, IMDB.movies M
WHERE MD.director_id = D.id
AND MG.movie_id = MD.movie_id
AND MG.genre = 'Drama'
AND M.id = MD.movie_id
AND M.rank != '\N'
GROUP BY DIRECTOR
ORDER BY MAX_RANK DESC, DIRECTOR