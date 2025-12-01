CREATE TABLE accounts (
	account_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	account_holder VARCHAR(100) NOT NULL,
	balance DECIMAL(10, 2) NOT NULL CHECK (balance >= 0)
);

DROP TABLE accounts;

INSERT INTO accounts (account_holder, balance) VALUES
('theo', 1000.00),
('seohyun', 2000.00);

SELECT * FROM accounts;

BEGIN;
UPDATE
	accounts
SET
	balance = balance + 500
WHERE
	account_holder = 'seohyun';
	
	
UPDATE
	accounts
SET
	balance = balance - 1500
WHERE
	account_holder = 'theo';
COMMIT;