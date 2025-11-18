-- query planner = 데이터베이스 최적화 엔진

-- <correlated subquery>는 메인 쿼리가 어떤 열에서 실행 중인지에 따라 결과값이 달라진다. 즉 independent query와 정반대이다.
-- correlated: 상관된

-- Q. 같은 해에 개봉된 영화의 평균 평점보다 높은 평점을 가진 영화를 찾으시오.

SELECT AVG(rating) FROM movies WHERE release_date = 2023;

SELECT
	title,
	director,
	rating
FROM
	movies
WHERE
	rating > (SELECT AVG(rating) FROM movies WHERE release_date = 2023); -- 여기서 하드 코딩한 2023을 where 문이
	-- 처리 중인 행의 개봉 년도로 바꾸어보자.

-- 이렇게

SELECT
	main_movies.title,
	main_movies.director,
	main_movies.rating
FROM
	movies AS main_movies
WHERE
	main_movies.rating > (
	SELECT 
		AVG(inner_movies.rating) 
	FROM 
		movies AS inner_movies 
	WHERE 
		inner_movies.release_date = main_movies.release_date
	)
; -- 이 쿼리를 실행하면 WHERE문이 가장 먼저 실행됨에 따라서 main_movies.release_date가 각 row를 돌며 계속 바뀌게 된다.
-- 예를 들어 inner_movies.release_date = 2023, inner_movies.release_date = 1988 이런 식으로 바뀌게 된다. 이것이 바로 correlated subquery이다.

-- 이 쿼리의 결과값은 where 절이 현재 처리 중인 행에 따라 변한다.

-- inner_movies.release_date = main_movies.release_date 이렇게 작성함으로써 외부의 쿼리에서 처리하고 있는 행에 대한 정보를 얻는다.

-- 하지만 위 쿼리는 255,000 * 255,000 총 650억 개의 row를 스캔하게된다.
-- 이대로 실행하면 안된다.   
-- 최적화가 되어 있지 않은 쿼리다.

-- 이렇게 최적화를 시킨다.
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
	release_date > 2022 AND -- 가장 처음에 온 조건이 거짓이면 뒤에 온 조건은 실행되지 않는다
	main_movies.rating > (
	SELECT 
		AVG(inner_movies.rating) 
	FROM 
		movies AS inner_movies 
	WHERE 
		inner_movies.release_date = main_movies.release_date
	)
;

-- 하지만 여전히 최적화가 더 필요하다!
-- 다음 강의에서 알아보자.