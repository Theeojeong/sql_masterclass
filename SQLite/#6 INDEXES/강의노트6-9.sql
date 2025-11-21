EXPLAIN query plan 
SELECT
	title
FROM
	movies
WHERE
	rating > 7;
	
	
CREATE INDEX idx on movies (rating, title);

DROP INDEX idx;



위에서 WHERE 절에는 rating > 7 밖에 없지만 INDEX에 title 컬럼을 추가해서 생성하고

query를 실행시키면 SEARCH movies USING COVERING INDEX idx (rating>?) 

이렇게 covering index를 사용한다

즉 DB가 INDEX 자체로 query를 처리할 수 있다는 얘기다

query에서 사용하고 있는 두 column에 대해 INDEX를 생성했기 때문에 DB는 main으로 점프를 할 필요가 없게 된다

DB가 query를 처리하고 data를 제공하는데 필요한 모든 data가 INDEX에 이미 있기 때문이다



covering index는 multi column index만큼 드라마틱하진 않지만 

훌륭한 성능 최적화를 제공하고 작업을 빠르게 만들 수 있고

multi column index와 결합하여 사용하면 최고다

covering index란 query의 요구사항을 완벽하게 만족시키는 index