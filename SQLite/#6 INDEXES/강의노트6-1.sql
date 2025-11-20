-- Table Scan이란
-- : 데이터베이스가 무언가를 찾기 위해서 한 행씩 찾아보는 것을 뜻한다.


-- 1. 감독의 career revenue가 평균보다 높은 감독을 찾으시오.

EXPLAIN query plan WITH director_stats AS ( -- explain query plan: 쿼리를 어떻게 실행할 것인지 계획을 알려주는 명령어
											-- 쿼리를 실행시키지 않고, 이 쿼리를 실행하기 위해 데이터베이스가 수행하는 단계를 보여준다
	SELECT
		director,
		COUNT(*) AS total_movies,
		AVG(rating) AS avg_rating,
		MAX(rating) AS best_rating,
		MIN(rating) AS worst_rating,
		MAX(budget) AS highest_budget,
		MIN(budget) AS lowest_budget
	FROM
		movies
	WHERE
		director IS NOT NULL
		AND budget IS NOT NULL
		AND rating IS NOT NULL
	GROUP BY
		director
)
SELECT
	director,
	avg_rating,
	total_movies,
	best_rating,
	worst_rating,
	highest_budget,
	lowest_budget,
	(
		SELECT
			title
		FROM
			movies
		WHERE
			rating IS NOT NULL
			AND budget IS NOT NULL
			AND director = ds.director
		ORDER BY
			rating DESC
		LIMIT 1) AS best_rated_movie,
	(
		SELECT
			title
		FROM
			movies
		WHERE
			rating IS NOT NULL
			AND budget IS NOT NULL
			AND director = ds.director
		ORDER BY
			rating ASC
		LIMIT 1) AS worst_rated_movie,
	(
		SELECT
			title
		FROM
			movies
		WHERE
			rating IS NOT NULL
			AND budget IS NOT NULL
			AND director = ds.director
		ORDER BY
			budget DESC
		LIMIT 1) AS most_expensive_movie,
	(
		SELECT
			title
		FROM
			movies
		WHERE
			rating IS NOT NULL
			AND budget IS NOT NULL
			AND director = ds.director
		ORDER BY
			budget ASC
		LIMIT 1) AS least_expensive_movie
FROM
	director_stats AS ds;

CREATE INDEX idx_director ON movies (director);
-- 인덱스를 생성하지 않고 EXPLAIN query plan을 보면 movies 전체를 여러번 SCAN 하지만 
-- 인덱스를 생성 후 EXPLAIN query plan을 보면 SCAN없이 INDEX를 사용하여 실행 속도가 기하급수적으로 빨라진다.

DROP INDEX idx_director;

-- Table Scan
-- 테이블 스캔은 데이터베이스가 무언가를 찾기 위해서 테이블의 모든 행을 하나씩 찾아보는 것을 말한다.
-- (테이블 전체를 처음부터 끝까지 스캔해야 하는 것)

-- query planner
-- query planner의 임무는 SQL 문을 완료하기 위한 가장 좋은 알고리즘이나 "쿼리 계획"을 찾아내는 것입니다.
-- https://www.sqlite.org/queryplanner-ng.html

-- query plan
-- query plan은 SQL 문을 DB에서 어떻게 처리할 지에 대한 것으로 어떤 방식과 순서로 실행되는 것이 가장 효율적인 지를 결정하는 실행 계획입니다.
-- SQL이 선언형이기 때문에 주어진 쿼리를 실행하기 위해 수많은 방법이 존재하는 것이 일반적이며 이에 따라 다양한 성능 차이를 보입니다.