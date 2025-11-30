-- SELECT
-- 	title,
-- 	CASE
-- 		WHEN revenue > budget THEN 'Hit'
-- 		WHEN revenue < budget THEN 'Flop'
-- 		ELSE 'N/A'
-- 	END
-- FROM
-- 	movies;
	

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