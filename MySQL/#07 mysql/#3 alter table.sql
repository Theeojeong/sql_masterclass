-- drop table
ALTER TABLE users DROP COLUMN joined_at;

-- rename column
ALTER TABLE users CHANGE COLUMN joined_at_auto joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL; -- change column 명렁어는 column 이름뿐만 아니라 칼럼의 타입도 바꿀 수 있다


-- modify column
ALTER TABLE users MODIFY COLUMN about_me TEXT; -- 타입만 변경하고 싶을 때


-- rename DB
ALTER TABLE users RENAME TO customers;
ALTER TABLE customers RENAME TO users;


-- drop constraints
ALTER TABLE users DROP CONSTRAINT unique_email;

-- adding constraints
ALTER TABLE users
	ADD CONSTRAINT uq_email UNIQUE (email),
	ADD CONSTRAINT uq_username UNIQUE (username);
	
ALTER TABLE users ADD CONSTRAINT chk_age CHECK (age < 100);


-- add or remove a NULL constraint
ALTER TABLE users MODIFY COLUMN bed_time TIME NULL;
ALTER TABLE users MODIFY COLUMN bed_time TIME NOT NULL;


SHOW CREATE TABLE users; -- DB가 내부적으로 테이블을 보는 방식을 확인할 수 있다



타입을 변경할 땐 기존 타입과 호환이 되는 타입으로 변경해야 한다
