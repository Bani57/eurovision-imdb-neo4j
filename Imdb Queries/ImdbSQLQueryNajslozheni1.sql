SELECT CONCAT(A.first_name,' ',A.last_name) AS ACTRESS, AVG(M.rank) AS AVG_RANK
FROM IMDB.actors A, IMDB.roles R, IMDB.movies M
WHERE A.gender = 'F'
AND A.last_name = 'Smith'
AND R.actor_id = A.id
AND M.id = R.movie_id
AND M.rank != '\N'
GROUP BY ACTRESS
ORDER BY AVG_RANK DESC