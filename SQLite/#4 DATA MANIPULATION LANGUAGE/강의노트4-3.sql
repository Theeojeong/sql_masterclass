-- <GROUP BY>
SELECT -- 4
	director,
	SUM(revenue) AS total_revenue
FROM -- 1
	movies
WHERE -- 2
	director IS NOT NULL 
	AND revenue IS NOT NULL
GROUP BY -- director를 기준으로 하는 그룹을 만든다 -- 3
	director
ORDER BY -- 5
	total_revenue DESC
;


SELECT
	release_date,
	round(AVG(rating), 2) AS avg_rating
FROM
	movies
WHERE
	release_date IS NOT NULL 
	AND rating IS NOT NULL
GROUP BY
	release_date
ORDER BY
	avg_rating DESC
;

	