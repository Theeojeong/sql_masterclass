-- fuction은 DML command에서 사용하기 위한 것이다

-- 예를 들어 뭔가를 select 할 때가 function을 가장 많이 사용하는 때다

-- function은 반드시 value를 return한다

CREATE FUNCTION hello_world()
RETURNS TEXT AS
$$
	SELECT 'hello world';
$$
LANGUAGE SQL;

SELECT hello_world();


CREATE FUNCTION hello_world(name TEXT)
RETURNS TEXT AS
$$
	SELECT 'hello' || name;
$$
LANGUAGE SQL;

SELECT hello_world('재현');


CREATE FUNCTION hello_world(TEXT, TEXT)
RETURNS TEXT AS
$$
	SELECT 'hello ' || $1 || ' 그리고 ' || $2;
$$
LANGUAGE SQL;



SELECT hello_world('재현', '서현');




drop FUNCTION is_hit_or_flop(movies);

CREATE OR REPLACE FUNCTION is_hit_or_flop(movie movies)
RETURNS TABLE (hit_or_flop TEXT, other_thing NUMERIC) AS
$$
	SELECT CASE
			WHEN movie.revenue > movie.budget THEN 'Hit'
			WHEN movie.revenue < movie.budget THEN 'Flop'
			ELSE 'N/A'
	END, 11111;
$$
LANGUAGE SQL;


SELECT
	title,
	(is_hit_or_flop(movies.*)).*
FROM
	movies;