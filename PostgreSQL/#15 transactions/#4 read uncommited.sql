-- <첫번째 isolation level>

-- Read uncommitted
-- 다른 트랜잭션이 만든 변경사항을 commit 하기 전에도 볼 수 있게 된다는 걸 의미한다
-- Dirty Read란?
-- "아직 COMMIT 안 된(더러운) 데이터를 읽어버리는 것"

-- MySQL은 repeatable read라고 한다

-- MySQL에서는 이런 코드를 작성해서 설정할 수 있다(다른 쿼리에서 A라는 트랜잭션을 실행했다는 가정 하에)

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;
	SELECT * FROM accounts;
COMMIT;

-- PostgreSQL에서는 이런 코드를 작성해서 설정할 수 있다

START TRANSACTION;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SELECT * FROM accounts;
COMMIT;