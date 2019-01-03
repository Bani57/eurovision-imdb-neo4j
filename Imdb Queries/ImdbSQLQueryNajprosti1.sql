SELECT M.*
FROM IMDB.movies M, IMDB.movies_genres MG
WHERE M.id = MG.movie_id
AND M.rank >= 7.0
AND M.year >= 1980
AND MG.genre = 'Horror'
ORDER BY M.year DESC, M.rank DESC
