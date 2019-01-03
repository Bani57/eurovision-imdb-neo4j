SELECT u.godina, u.pesna as pesna, a.zemjaPoteklo FROM uchestvo AS u
JOIN pesna as p ON p.id = u.pesna
JOIN izveduvach as a ON a.id = p.avtor
WHERE (u.vecher = "SF1" or u.vecher = "SF2")
AND u.mesto = 11
AND u.poeni = (SELECT MAX(z.poeni) FROM uchestvo AS z
	WHERE (z.vecher = "SF1" or z.vecher = "SF2")
	AND z.mesto = 11
    AND z.godina =  u.godina) 
GROUP BY u.godina
ORDER BY u.godina;