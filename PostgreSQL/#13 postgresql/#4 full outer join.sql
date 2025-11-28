-- FULL OUTER JOIN
-- 합집한
SELECT
	movies.title,
	directors.name
FROM
	movies
	FULL OUTER JOIN directors USING (director_id);
	
	
-- FULL OUTER JOIN *
-- 합집합 - 교집합
SELECT
	movies.title,
	directors.name
FROM
	movies
	FULL OUTER JOIN directors USING (director_id)
WHERE
	movies.director_id IS NULL OR directors.director_id IS NULL
;


SELECT
	*
FROM
	movies
	FULL OUTER JOIN directors USING (director_id);