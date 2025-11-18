-- 1. 감독의 career revenue가 평균보다 높은 감독을 찾으시오.
WITH directors_revenues AS (
	SELECT
		director,
		SUM(revenue) AS career_revenue
		
	FROM
		movies
	WHERE
		director IS NOT NULL
		AND revenue IS NOT NULL
	GROUP BY
		director
), avg_director_career_revenue AS (
	SELECT
		AVG(career_revenue)
	FROM
		directors_revenues
) -- CTE 2개

SELECT
	director,
	SUM(revenue) AS total_revenue,
	(SELECT * FROM avg_director_career_revenue) AS peers_avg
FROM
	movies
WHERE
	director IS NOT NULL
	AND revenue IS NOT NULL
GROUP BY
	director
HAVING
	total_revenue > (SELECT * FROM avg_director_career_revenue);
	

-- 2. 해당 장르에서 평균보다 높은 평점을 보유한 영화의 목록을 나열하시오.