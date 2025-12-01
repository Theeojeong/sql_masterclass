BEGIN;
UPDATE
	accounts
SET
	balance = balance + 4500
WHERE
	account_holder = 'seohyun';

SELECT * FROM accounts;
	
SAVEPOINT first_savepoint;
	
UPDATE
	accounts
SET
	balance = 1000000
WHERE
	account_holder = 'theo';

ROLLBACK TO SAVEPOINT first_savepoint;
-- ROLLBACK -> 그냥 롤백은 작업 내용 전부 취소
	
COMMIT;