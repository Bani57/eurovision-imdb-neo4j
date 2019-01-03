SELECT nadvorRegion.Zemja, voRegion.pointsVo / (voRegion.pointsVo + nadvorRegion.pointsOut) AS "region/vkupno"
FROM 
(
	SELECT eg.zemja2 AS Zemja, SUM(eg.poeni) AS pointsVo
	FROM eurovision.zemja AS koj 
	JOIN eurovision.glasanje AS eg
	ON koj.ime = eg.zemja1
    JOIN eurovision.zemja AS kogo
    ON kogo.ime = eg.zemja2
	WHERE eg.godina = 2009
    AND kogo.region = koj.region
	GROUP BY Zemja
) AS voRegion
JOIN
(
	SELECT eg.zemja2 AS Zemja, SUM(eg.poeni) AS pointsOut
	FROM eurovision.zemja AS koj 
	JOIN eurovision.glasanje AS eg
	ON koj.ime = eg.zemja1
    JOIN eurovision.zemja AS kogo
    ON kogo.ime = eg.zemja2
	WHERE eg.godina = 2009
    AND kogo.region != koj.region
	GROUP BY Zemja
) AS nadvorRegion
ON voRegion.Zemja = nadvorRegion.Zemja

;
