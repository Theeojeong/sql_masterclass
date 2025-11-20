-- create index 는 DDL이다

-- CREATE INDEX 보통 idx로 시작하고 뒤에는 내가 색인하려고 하는 열의 이름을 적어서 INDEX 이름을 짓는다

-- EXPLAIN query plan 


SELECT
	*
FROM
	movies
WHERE
	director = 'Guy Ritchie';

CREATE INDEX idx_director ON movies (director);

DROP INDEX idx_director;