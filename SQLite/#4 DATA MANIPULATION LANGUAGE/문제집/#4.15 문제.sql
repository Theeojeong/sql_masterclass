-- 1. 각 년도에 개봉된 영화의 수를 알아내시오
SELECT
	release_date,
	count(*) total_movie
FROM
	movies
WHERE
	release_date IS NOT NULL
GROUP BY
	release_date
ORDER BY
	total_movie DESC
;

-- 2. 평균 영화 상영 시간이 가장 높은 상위 10년을 나열해보시오.
SELECT
	release_date,
	round(AVG(runtime), 1) AS avg_runtime
FROM
	movies
WHERE
	runtime IS NOT NULL AND release_date IS NOT NULL
GROUP BY
	release_date
ORDER BY
	avg_runtime DESC
LIMIT
	10;

-- 3. 21세기에 개봉한 영화의 평균 평점을 계산해보시오.
SELECT

	AVG(rating) AS avg_rating
FROM
	movies
WHERE
	release_date > 1999 AND rating IS NOT NULL
-- GROUP BY
-- 	release_date
-- ORDER BY
-- 	avg_rating DESC
;

-- 4. 평균 영화 상영 시간이 가장 긴 감독을 찾으시오.
SELECT
	director,
	AVG(runtime) AS avg_runtime
FROM
	movies
WHERE
	runtime IS NOT NULL AND director IS NOT NULL
GROUP BY
	director
ORDER BY
	avg_runtime DESC
	;

-- 5. 가장 많은 영화를 작업한 다작 감독 상위 5명을 나열하시오.
SELECT
	director,
	COUNT(*) AS total_movies
FROM
	movies
WHERE 
	director IS NOT NULL
GROUP BY
	director
ORDER BY
	total_movies DESC
LIMIT
	5;
	
-- 6. 각 감독의 최고 평점과 최저 평점을 찾으시오.
SELECT
	director,
	MAX(rating),
	MIN(rating)
FROM
	movies
WHERE 
	director IS NOT NULL AND rating IS NOT NULL
GROUP BY
	director
HAVING
	COUNT(*) > 3
;

-- 7. 돈을 가장 많이 벌어들인 감독을 찾으시오. (수익-예산)
SELECT
	director,
	SUM(budget) AS total_budget, -- 예산
	SUM(revenue) AS total_revenue, -- 수익
	SUM(revenue) - SUM(budget) AS final_revenue
	
FROM
	movies
WHERE
	director IS NOT NULL AND 
	budget IS NOT NULL AND
	revenue IS NOT NULL
GROUP BY
	director
ORDER BY
	final_revenue DESC
;

-- 8. 2시간 이상인 영화들의 평균 평점을 구하시오.
SELECT
	AVG(rating)
FROM
	movies
WHERE
	runtime > 120 AND
	rating IS NOT NULL;

-- 9. 가장 많은 영화가 개봉된 년도를 찾으시오.
SELECT
	release_date,
	COUNT(*) AS total_movies
	
FROM
	movies
WHERE
	release_date IS NOT NULL
GROUP BY
	release_date
ORDER BY
	total_movies DESC
;

-- 10. 각 10년 동안의 평균 영화 상영 시간을 구해보시오.
SELECT
	(release_date / 10) * 10 AS decade,
	AVG(runtime)
FROM
	movies
WHERE
	runtime IS NOT NULL AND
	release_date IS NOT NULL
GROUP BY
	decade
;

