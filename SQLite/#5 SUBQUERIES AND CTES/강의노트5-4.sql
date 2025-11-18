SELECT
	main_movies.title,
	main_movies.director,
	main_movies.rating,
	main_movies.release_date,
	(
	SELECT 
		AVG(inner_movies.rating) 
	FROM 
		movies AS inner_movies 
	WHERE 
		inner_movies.release_date = main_movies.release_date
	) AS year_average
FROM
	movies AS main_movies
WHERE
	release_date > 2022 AND
	main_movies.rating > (
	SELECT 
		AVG(inner_movies.rating) 
	FROM 
		movies AS inner_movies 
	WHERE 
		inner_movies.release_date = main_movies.release_date
	)
;

-- 이렇게 바꾸자
WITH movie_avg_per_year AS (
	SELECT 
		AVG(inner_movies.rating) 
	FROM 
		movies AS inner_movies 
	WHERE 
		inner_movies.release_date = main_movies.release_date
) -- 이것이 CTE 내에 있는 correlated subquery이다. correlated CTE이다.
-- CTE가 main_movies 테이블에 우리가 붙여준 별칭을 참조하고 있다
-- 참고로 이 동작은 sqlite에서만 작동한다, MySQL이나 PostgreSQL에서는 하위에 있는걸 참조하는 CTE는 사용할 수 없다.
-- movies AS main_movies는 CTE를 정의한 후에 붙여진 것이기 때문에 MySQL이나 PostgreSQL에서는 CTE 하위에 있는 것을 참조하지 못한다.
-- CTE 정의 이전에 있는 것들만 참조할 수 있다

SELECT
	main_movies.title,
	main_movies.director,
	main_movies.rating,
	main_movies.release_date,
	(SELECT * FROM movie_avg_per_year) AS year_average
FROM
	movies AS main_movies
WHERE
	release_date > 2020 AND
	main_movies.rating > (SELECT * FROM movie_avg_per_year)
;

-- 하지만 위 쿼리도 여전히 성능이 좋지 않고 다음 강의에서 어떻게 index를 통해 이 쿼리를 최적화할 수 있는지 배운다