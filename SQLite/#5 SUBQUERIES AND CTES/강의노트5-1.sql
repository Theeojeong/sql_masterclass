-- 1. 전체 영화들 중, 평점이나 수익이 평균보다 높은 영화의 리스트를 알아내시오.
-- <independent subquery>
SELECT AVG(rating) FROM movies; -- 값: 5.7346691258

SELECT 
	COUNT(*)
FROM 
	movies
WHERE
	revenue > 1000 AND
	rating > 5.7346691258;

-- 이 대신 

SELECT 
	COUNT(*)
FROM 
	movies
WHERE
	revenue > 1000 AND
	rating > (
			SELECT
				AVG(rating)
			FROM
				movies);  -- 여기에 편입 시키는 것을 subquery
-- subquery는 다른 쿼리의 내부에 있는 쿼리고, 단순히 괄호로 감싸면 된다

-- where 문에 편입 시킨다 -> 이것을 subquery라고 부르고 위 subquery는 independent subquery이다. 
-- where 문은 모든 row를 참조하는데
-- independent subquery는 각 row에 따라 값이 달라지지 않는다.
-- SQL은 똑똑하게도 independent subquery의 결과값을 기억해서 나머지 영화들을 필터링한다 --> 이 작업은 query planner가 한다.