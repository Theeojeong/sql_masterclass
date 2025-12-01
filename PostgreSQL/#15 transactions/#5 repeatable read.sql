-- <두번째 isolation level>

-- Repeatable read
-- 다른 트랜잭션이 만든 변경사항을 commit 하기 전에도 볼 수 있게 된다는 걸 의미한다
-- A 트랜잭션에서 commit을 하더라도 A 트랜잭션을 조회하는 B 트랜잭션에서는 항상 commit 하기 전 데이터를 조회 한다
-- 즉 다른 누군가가 변경 사항을 commit 해도, 이전의 값을 계속 보게 된다
-- Repeatable read은 데이터베이스의 스냅샷을 찍는 것과 유사하다

-- MySQL은 repeatable read라고 한다

-- MySQL에서는 이런 코드를 작성해서 설정할 수 있다(다른 쿼리에서 A라는 트랜잭션을 실행했다는 가정 하에)

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
	SELECT * FROM accounts;
COMMIT;

-- PostgreSQL에서는 이런 코드를 작성해서 설정할 수 있다

START TRANSACTION;
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	SELECT * FROM accounts;
COMMIT;


-- 스냅샷이 찍히는 시점
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;을 설정할 때 찍히는 게 아니라
SELECT * FROM accounts; 이렇게 처음으로 non-transaction 명령문이 실행될 때 찍힌다, select, update 등등
처음으로 읽는 그 순간에 스냅샷이 생성된다

repeatable read 는 다시 정리하자면
트랜잭션이 항상 같은 값을 읽는 것을 보장해주는 것이다 
dirty read에서는 다른 트랜잭션에서 commit전에 데이터를 수정하면
다른 값을 보지만
repeatable read 에서는 스냅샷이 한번 생성되면 항상 스냅샷을 조회한다
