CREATE TABLE genres (
	genre_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, -- BIGSERIAL 도 1씩 증가하는 PRIMARY KEY를 얻게 되는 건 같지만 문제는 누군가 genre_id를 55로 업데이트하는 쿼리를 날리면 그럼 genre_id가 바뀌게 된다. 업데이트 명령어로 genres 테이블의 genre_id를 아무렇게나 수정할 수 있다. 
	-- 하지만 위 쿼리는 1씩 증가하는 BIGINT를 얻을 수 있지만 나중에 변경이 불가능하다. 이게 SQL 표준을 더 잘 따르는 방식이다.
	name VARCHAR(50) UNIQUE,
	created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL, -- TIMESTAMPTZ = TIMESTAMP WITH TIME ZONE
	updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

INSERT INTO
	genres (name)
SELECT 
	DISTINCT UNNEST(string_to_array(genres, ','))
FROM
	movies
GROUP BY
	genres
	;
	
SELECT
	movies.title,
	movies.movie_id,
	genres.genre_id,
	genres.name
FROM
	movies
	JOIN genres ON movies.genres LIKE '%' || genres.name || '%';
	
CREATE TABLE movies_genres(
	movie_id BIGINT NOT NULL,
	genre_id BIGINT NOT NULL,
	created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
	
	PRIMARY KEY (movie_id, genre_id),
	FOREIGN KEY (movie_id) REFERENCES movies (movie_id),
	FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
	);