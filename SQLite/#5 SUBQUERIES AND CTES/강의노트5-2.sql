-- <CTE> Common Table Expression: independent subquery를 재사용할 수 있게 해준다.

SELECT 
	title,
	director,
	revenue,
	(SELECT
		AVG(revenue)
	FROM
		movies) AS avg_revenue
FROM 
	movies
WHERE
	revenue > (
			SELECT
				AVG(revenue)
			FROM
				movies); 

-- 이 대신

WITH avg_revenue_cte AS (
	SELECT
		AVG(revenue)
	FROM
		movies), -- 이렇게 CTE로 변환한다
	avg_rating_cte AS (
	SELECT
		AVG(rating)
	FROM
		movies) -- 이렇게 CTE를 여러개 작성할 수 있다

SELECT 
	title,
	director,
	revenue,
	rating,
	(SELECT * FROM avg_revenue_cte) AS avg_revenue,
	(SELECT * FROM avg_rating_cte) AS avg_rating
FROM 
	movies
WHERE
	revenue > (SELECT * FROM avg_revenue_cte) AND
	rating > (SELECT * FROM avg_rating_cte); 


-- CTE는 테이블을 return한다