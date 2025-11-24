-- Computed Column (Generated Column)
-- Generated Column 이란 다른 Column을 사용하여 값을 도출하는 Column이다


CREATE TABLE users_v2 (
 	user_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 	first_name VARCHAR(50),
 	last_name VARCHAR(50),
 	email VARCHAR(100),
 	full_name VARCHAR(101) GENERATED ALWAYS AS (CONCAT(first_name, ' ', last_name)) STORED
);

INSERT INTO users_v2 (
	first_name, last_name, email
) VALUES ('jeong', 'theo', 'wogusto13@gmail.com');


ALTER TABLE users_v2 ADD COLUMN email_domain VARCHAR(50) GENERATED ALWAYS AS 
(SUBSTRING_INDEX(email, '@', -1)) VIRTUAL; -- 이 쿼리는 SQLite에서도 가능하다

-- Generated Column에서 VIRTUAL과 STORED의 차이:
-- VIRTUAL Generated Column은 디스크나 DB에 저장되지 않는다, email_domain Column을 조회할 때마다 매번 연산을 수행한다
-- Column을 SELECT할 때마다 그때그때 연산을 한다
-- 하지만
-- STORED는 정반대다. 

-- 결론은, 어떤 field에 대해 쿼리가 꽤 자주 실행되고, 조회 속도가 빨라야 하고 수정이나 삽입은 좀 느려도 상관 없고, 디스크 공간도 신경 쓰지 않는다면 그땐 STORED를 쓰면 된다.
-- 하지만 어떤 field가 쿼리는 그닥 자주 실행되지 않아서 조회 속도가 좀 느려도 상관 없고 굳ㄷ이 데이터베이스에 저장하여 저장 공간에 대한 비용을 지불하고 싶지 않다면 VIRTUAL을 사용하면 된다.

-- CONCAT 함수: 여러 TEXT 조각들을 하나로 합쳐준다
-- EX)
SELECT CONCAT('hello', ' ', 'world');

-- SUBSTRING_INDEX 함수
-- EX)
SELECT SUBSTRING_INDEX('nico@nomad.com', '@', -1); -- (분리하고자 하는 것 , 분리 기준값, 1(기준에서 왼쪽 출력) or -1(오른쪽 출력))

SELECT * FROM users_v2;