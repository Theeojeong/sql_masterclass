-- <HAVING>
-- HAVING이 하는 일은 딱 WHERE 같은데 row를 필터링 할 수 있게 해준다.
-- 하지만 HAVING은 GROUP BY를 사용하여 생성된 column과 집계 함수를 사용해 생성된 column을 볼 수 있다
SELECT -- 5
	release_date,
	AVG(rating) AS avg_rating 
FROM -- 1
	movies
WHERE -- 2
	release_date IS NOT NULL AND rating IS NOT NULL
GROUP BY -- 3
	release_date
HAVING -- 4
	avg_rating > 6
ORDER BY -- 6
	avg_rating DESC;
-- HAVING이 어떻게 뒷 순서인 SELECT 문에서 정의된 avg_rating을 참조하는 건가요?
-- : SQL 엔진이 실제로 실행하기 전에 쿼리에 사용된 모든 열과 표현식을 식별하기 때문입니다.

-- SELECT [DISTINCT | ALL] 컬럼 OR 그룹함수, ...
-- FROM 테이블
-- WHERE 조건
-- GROUP BY 그룹대상
-- HAVING <그룹 함수 포함 조건>
-- ORDER BY 정렬대상

---------------------------------------------------------------------------------------------------------
-- Q. 각 감독의 평균 rating이 얼마인가요?
SELECT
	director,
	AVG(rating) AS avg_rating

FROM movies

WHERE director IS NOT NULL AND rating IS NOT NULL

GROUP BY director

ORDER BY
	avg_rating DESC;

---------------------------------------------------------------------------------------------------------
-- Q. 5편 이상의 영화를 가진 각  감독의 평균 rating이 얼마인가요?

SELECT 
	director,
	-- COUNT(*) as number_of_movies,
	round(AVG(rating), 1) as avg_rating

FROM movies 

WHERE 
	director IS NOT NULL AND 
	rating IS NOT NULL AND 
	title IS NOT NULL
GROUP BY
	director
HAVING
	COUNT(*) > 5
ORDER BY
	avg_rating DESC
;

---------------------------------------------------------------------------------------------------------
-- Q. 각 장르에 몇 편의 영화가 있나요?

SELECT
	genres,
	COUNT(*) AS total_movies
FROM
	movies
WHERE
	genres IS NOT NULL
GROUP BY
	genres
ORDER BY
	total_movies DESC
;

---------------------------------------------------------------------------------------------------------
-- Q. 평점이 6보다 높은 영화는 몇 편인가요? 그리고 가장 흔한 평점은 무엇인가요?

SELECT
	rating,
	COUNT(*) AS total_movies -- as는 생략이 가능하다
FROM
	movies
WHERE
	rating > 6
GROUP BY
	rating
ORDER BY
	total_movies DESC
;

-- 가장 흔한 평점: 7점, 평점이 6보다 높은 영화 편수: 
