-- <view> 쿼리를 저장하는 명령어
-- view를 사용하는 이유는 가끔 자주 사용하게 될 쿼리가 생기기 때문.
-- 쿼리 전체를 파일에 저장해서 실행할 때마다 매번 복붙하는 대신에,
-- view를 사용해서 쿼리를 패키징할 수 있다


CREATE view v_flop_or_not as SELECT -- SELECT문 앞에 CREATE VIEW (view 이름) AS 를 추가한다다
	case when revenue < budget then 'flop'
	else 'success' END as flop_or_not,
	count(*)
FROM
	movies
WHERE
	budget is not null and revenue is not null
group BY
	flop_or_not;

위 쿼리를 실행하면 위 쿼리를 삭제해도 

SELECT * FROM v_flop_or_not 으로 실행할 수 있다
또한 VIEW를 테이블 처럼 사용할 수 있다.

-- VIEW를 삭제하는 방법
DROP VIEW v_flop_or_not;