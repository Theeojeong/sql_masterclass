SELECT
	*
FROM 
	movies
WHERE
	director = 'Guy Ritchie'; -- != 이것과 <> 이것은 같은 표현이다.
	

SELECT
	*
FROM 
	movies
WHERE
	revenue IS NULL; -- NULL 값을 찾고 싶다면 IS NULL 혹은 IS NOT NULL

  