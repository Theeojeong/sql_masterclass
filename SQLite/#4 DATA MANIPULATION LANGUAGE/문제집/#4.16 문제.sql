-- 1. 영화의 최고 평점과 최저 평점 차이가 가장 큰 상위 5개 연도를 나열하시오.
SELECT
	release_date,
	max(rating) - min(rating) AS diff_rating
FROM
	movies
WHERE
	rating IS NOT NULL AND
	release_date IS NOT NULL
GROUP BY
	release_date
ORDER BY
	diff_rating DESC
	;