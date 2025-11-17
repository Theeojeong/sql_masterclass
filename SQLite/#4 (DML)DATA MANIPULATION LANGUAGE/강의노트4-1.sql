-- <AND, OR>
SELECT
	*
FROM 
	movies
WHERE
	director = 'Guy Ritchie'; -- != 이것과 <> 이것은 같은 표현이다.
	
---------------------------------------------------------------------------------------------------------
SELECT
	*
FROM 
	movies
WHERE
	revenue IS NULL; -- NULL 값을 찾고 싶다면 IS NULL 혹은 IS NOT NULL

---------------------------------------------------------------------------------------------------------
SELECT
	*
FROM
	movies
WHERE
	rating > 9
	OR (rating IS NULL AND genres = 'Documentary'); -- AND 연산자와 OR 연산자 사용

---------------------------------------------------------------------------------------------------------
SELECT
	*
FROM
	movies
WHERE
	release_date BETWEEN 2020 AND 2024; -- BETWEEN 연산자 사용
  

-- <membership condition> IN, NOT IN
SELECT
	*
FROM
	movies
WHERE
	genres IN ('Documentary', 'Comedy'); -- genres = 'Documentary' OR genres = 'Comedy'; 이것과 같은 명령어
  

-- <Pattern matching> LIKE, %, ___
SELECT
	*
FROM
	movies
WHERE
	title LIKE 'The%'; -- title이 the로 시작하는 영화를 찾는 명령어. 
  -- %는 와일드카드라고 부름, 나머지 부분은 신경 쓰지 않는다는 뜻.

---------------------------------------------------------------------------------------------------------
SELECT
	*
FROM
	movies
WHERE
	title LIKE '%The%'; -- title에 The가 포함되어 있는 영화를 찾는 명령어.

---------------------------------------------------------------------------------------------------------
SELECT
	*
FROM
	movies
WHERE
	overview LIKE '%kimchi%'; -- overview에 kimchi가 포함되어 있는 영화를 찾는 명령어.

---------------------------------------------------------------------------------------------------------
SELECT
	*
FROM
	movies
WHERE
	title LIKE '___ing'; -- ___는 %와 비슷, 빈칸이든 문자든 숫자든 ___로 시작해 ing로 끝나는 영화를 찾는 명령어.

---------------------------------------------------------------------------------------------------------
SELECT
	*
FROM
	movies
WHERE
	title LIKE 'The __'; -- The 뒤에 띄어쓰기와 2개의 문자로 끝나는 영화를 찾는 명령어.

---------------------------------------------------------------------------------------------------------
SELECT
	*
FROM
	movies
WHERE
	title LIKE 'The ___ %';


-- <SELECT CASE> WHEN, THEN
SELECT
	title,
	CASE WHEN rating >= 8 THEN '^-^' WHEN rating <= 6 THEN 'ㅠ.ㅠ' -- WHEN 은 if와 같다, WHEN이 TRUE일때 THEN을 실행
	END AS good_or_not
FROM movies;