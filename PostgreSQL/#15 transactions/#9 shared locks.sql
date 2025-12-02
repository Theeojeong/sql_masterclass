-- 격리 레벨은 트랜잭션이 내부에서 외부 세계를 어떻게 바라보는지에 대한 것이다

BEGIN;
	SELECT
		balance
	FROM
		accounts
	WHERE
		account_holder = 'lynn'
	FOR UPDATE;
COMMIT;

SELECT FOR UPDATE는 실행되고 나면 commit 할 때까지 아무도 이 row를 건드릴 수 없다는 것을 의미한다


	SELECT
		balance
	FROM
		accounts
	WHERE
		account_holder = 'lynn'
	FOR SHARE;
COMMIT;

위 코드도 마찬가지로 실행되고 나면 commit 할 때까지 아무도 이 row를 건드릴 수 없다는 것을 의미한다

SELECT FOR SHARE와 SELECT FOR UPDATE의 차이는 뭘까?

바로 각자 생성하는 lock의 종류가 다르다는 것이다

SELECT FOR UPDATE는 exclusive lock을 생성한다

말하자면 그 row를 얼려버리는 것과 같이 아무도 건드릴 수 없게 된다

또한 다른 곳해서 해당 row를 lock을 걸 수 없다

하지만 SELECT FOR SHARE에서는 다른 곳에서도 해당 row에 lock을 걸 수 있다

