-- migration: 데이터 옮기기, 데이터 이동
-- 데이터 타입을 바꾸고 싶은데 이미 데이터가 존재하는 경우에 어떻게 해야 할까

ALTER TABLE users MODIFY COLUMN graduation_year DATE; -- > 이미 데이터가 존재 해서 실행 불가

-- 방법 1. column을 새로 만든다
ALTER TABLE users ADD COLUMN graduation_date DATE;

UPDATE users SET graduation_date = MAKEDATE(graduation_year, 78); -- migration 성공

-- 이제 graduation_date는 필요 없으니 삭제
ALTER TABLE users DROP COLUMN graduation_year;

-- graduation_date에 NULL값을 허용하지 않도록 NOT NULL 타입을 추가해주자
ALTER TABLE users MODIFY COLUMN graduation_date DATE NOT NULL;


-- 방법 2. 

ALTER TABLE users ADD COLUMN graduation_date DATE NOT NULL DEFAULT MAKEDATE(graduation_year, 78);



SHOW CREATE TABLE users;


