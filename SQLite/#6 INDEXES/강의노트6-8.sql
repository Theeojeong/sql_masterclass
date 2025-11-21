

SELECT
	title
FROM
	movies
WHERE
	release_date = 2022
	AND rating > 7;
	
CREATE INDEX idx ON movies (release_date, rating);


EXPLAIN query plan SELECT
	title
FROM
	movies
WHERE
	release_date = 2022
	AND rating > 7;
	
CREATE INDEX idx ON movies (release_date, rating);


다중 column에 대한 index를 생성하는 시간을 가질거임

모든 쿼리에 대해서 INDEX를 생성할 필요가 없음
최적화 하고 싶고 자주 사용하게될 query에 INDEX를 만들어야함

INDEX의 (release_date, rating) 에는 순서가 있고 순서는 매우 중요하다
가장 많이 사용하는 column을 INDEX 처음에 두어야함

제일 많이 검색하는  항목은 INDEX의 시작으로 가야한다

DB는 범위 조건을 찾기 전까지 INDEX 전체를 사용하려 한다

= 검색을 많이 사용하는 column이 있다면 이걸 시작 부분에 넣어주면 되고

다음으로는 적게 사용하는 column 이나 범위 검색을 사용하는 column을 넣어주면 된다

	
