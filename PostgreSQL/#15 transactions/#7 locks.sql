-- Lock이 뭔가?
-- 여러 트랜잭션이 동시에 같은 데이터를 건드릴 때 충돌을 막는 메커니즘입니다.
-- 비유:

-- 화장실 = 데이터
-- 사용 중 표시 = Lock
-- 다른 사람은 대기

-- 2개의 트랜잭션이 있고, 같은 row에 대해서 업데이트하려고 할 때

-- tx A
BEGIN;
	UPDATE
		accounts
	SET
		balance = balance + 200
	WHERE
		account_holder = 'seohyun';
		
	SELECT * FROM accounts;

COMMIT;


-- tx B(다른 장소)
BEGIN;
	UPDATE
		accounts
	SET
		balance = balance - 100
	WHERE
		account_holder = 'seohyun';
		
	SELECT * FROM accounts;

COMMIT;

두개의 트랜잭션이 서로 같은 row를 바라볼 때면

먼저 실행한 트랜잭션의 row가 commit하거나 roll back하기 전까지 lock에 걸린다(read committed인 경우에)


-- repeatable read일 때 어떤 일이 벌어질까

-- tx A
BEGIN;
	UPDATE
		accounts
	SET
		balance = balance + 200
	WHERE
		account_holder = 'seohyun';
		
	SELECT * FROM accounts;

COMMIT;


-- tx B(다른 장소)
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	UPDATE
		accounts
	SET
		balance = balance - 100
	WHERE   
		account_holder = 'seohyun';
		
	SELECT * FROM accounts;

COMMIT;

repeatable read의 핵심은 값이 변경되면 안된다는 거였다

committed read에서는 값이 변경되더라도 commit 상태라면 괜찮았다

하지만 repeatable read에서는 트랜잭션이 시작된 이후에 값이 변경되는 걸 허용하지 않는다


