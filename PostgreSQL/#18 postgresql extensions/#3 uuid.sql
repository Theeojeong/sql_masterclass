-- UUID (Universally Unique Identifier)는 전 세계적으로 고유한 식별자.

-- 데이터가 너무 많아서 BIGINT로 표현할 수 있는 범위를 넘어가버릴 때 UUID를 사용한다

DROP TABLE users;

CREATE EXTENSION "uuid-ossp";

CREATE TABLE users (
	user_id  UUID PRIMARY KEY DEFAULT(uuid_generate_v4()),
	username VARCHAR(100),
	password VARCHAR(100)
);

INSERT INTO users (username, PASSWORD) VALUES ('theo', 'kjs1673');

SELECT * FROM users;