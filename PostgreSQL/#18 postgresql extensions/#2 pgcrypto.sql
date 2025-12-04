-- pgcrypto: 데이터베이스에서 암호화 작업을 실행할 수 있도록 해준다

CREATE EXTENSION pgcrypto;

CREATE TABLE users (
	user_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	username VARCHAR(50),
	password VARCHAR(100)
);

INSERT INTO users (username, PASSWORD) VALUES
	('theo', crypt('kjs1673', gen_salt('bf')));


SELECT * FROM users;

ALTER TABLE users
ALTER COLUMN PASSWORD TYPE VARCHAR(100);


SELECT
	username
FROM
	users
WHERE
	password = crypt('kjs1673', password); -- crypt()의 두번째 매개변수는 칼럼명