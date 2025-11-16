-- <sql문 실행순서>
SELECT -- 3
FROM -- 1
WHERE -- 2
ORDER BY -- 4


-- <ORDER BY>
SELECT
	*
FROM
	movies
-- WHERE
-- 	director = 'Darren Aronofsky'
ORDER BY 
	release_date DESC,
	revenue DESC; -- ORDER BY 조건을 하나 추가해줌으로서 release_date가 같을 때 두번 째 조건을 기준으로 정렬할 수 있다.


-- <LIMIT, OFFSET>
SELECT -- 3
	*
FROM -- 1
	movies
WHERE -- 2
LIMIT 5  -- 데이터 조회 갯수 제한 -- 5
OFFSET 2 * 5; -- 스킵 기능, N번째 row에서 시작하도록 설정 가능 -- 4

---------------------------------------------------------------------------------------------------------
SELECT -- 3
	*
FROM -- 1
	movies
WHERE -- 2
ORDER BY -- 4
LIMIT 5  -- 데이터 조회 갯수 제한 -- 6
OFFSET 2 * 5; -- 스킵 기능, N번째 row에서 시작하도록 설정 가능 -- 5

-- 1. FROM으로 movies 테이블을 작업 테이블로 설정
-- 2. WHERE 조건을 사용해서 많은 row를 걸러낸다
-- 3. SELECT으로 결과 테이블에 표시되어야 하는 column을 선택한다
-- 4. ORDER BY에 작성한 기준으로 row의 순서가 지정된다
-- 5. 특정 개수의 row를 건너뛰기 위해서 OFFSET이 호출된다
-- 6. 마지막으로 총 row 수를 제한하기 위해 LIMIT이 호출된다