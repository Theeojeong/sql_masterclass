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

-- 2. 2시간 미만의 영화를 만들어 본 적이 한 번도 없는 감독을 찾으시오.
SELECT
	director,
	MIN(runtime) AS min_runtime
FROM
	movies
WHERE
	runtime IS NOT NULL AND director IS NOT NULL
GROUP BY
	director
HAVING
	min_runtime > 120
	;
-- 3. 전체 영화에서 평점이 8.0 초과인 영화의 비율
SELECT
	COUNT(CASE WHEN rating > 8 THEN 1 END) * 100 / COUNT(*) AS rate_of_over_8
FROM
	movies
;

-- 4. 평점이 7.0보다 높은 영화가 차지하는 비율이 가장 높은 감독
SELECT
	director,
	COUNT(CASE when rating > 7.0 then 1 end) * 100 / COUNT(*) AS good_director
	
FROM
	movies
WHERE
	rating is not null and director is not NULL
group BY
	director
HAVING
	COUNT(*) > 10
ORDER BY
	good_director DESC
;
-- 5. 길이별로 영화를 분류하고 그룹화하기
SELECT
	 case when runtime < 90 then 'short'
	 when runtime between 90 and 120 then 'medium'
	 when runtime > 120 then 'long' END as runtime_category,
	 count(*)
FROM
	movies
WHERE
	runtime is not NULL
GROUP BY
	runtime_category;
-- 6. flop 여부에 따라 영화를 분류 및 그룹화하기(flop: 수익보다 비용이 더 많이 나가는 영화)
SELECT
	case when revenue < budget then 'flop'
	else 'success' END as flop_or_not,
	count(*)
FROM
	movies
WHERE
	budget is not null and revenue is not null
group BY
	flop_or_not;