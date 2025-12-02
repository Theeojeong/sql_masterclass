-- users라는 테이블을 만들어요.
-- user_id는 자동으로 1, 2, 3... 순서대로 번호가 매겨지는 Primary Key(고유 번호)예요.
-- profile은 JSONB 타입으로, JSON 형식의 다양한 정보를 저장할 수 있어요.
CREATE TABLE users (
	user_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	profile JSONB
);

-- users 테이블에 2명의 사용자 정보를 추가해요.
-- JSON 문자열을 직접 넣는 방법이에요.
INSERT INTO users (profile) VALUES
('{"name": "Taco", "age": 30, "city": "Budapest"}'),
('{"name": "Giga", "age": 25, "city": "Tbilisi", "hobbies": ["reading", "climbing"]}');

-- json_build_object 함수를 사용해서 JSON 객체를 생성.
-- 이름, 나이, 도시 정보를 가진 JSON을 생성해서 보여줘요.
-- (테이블에 저장하지는 않고 그냥 출력만 해요)
SELECT json_build_object('name', 'theo', 'age', 30, 'city', 'Budapest');

-- json_build_object와 json_build_array 함수를 함께 사용해요.
-- 취미(hobbies)처럼 여러 개의 값을 배열로 만들 때 json_build_array를 써요.
-- (테이블에 저장하지는 않고 그냥 출력만 해요)
SELECT json_build_object('name', 'Giga', 'age', 25, 'city', 'Tbilisi', 'hobbies', json_build_array('reading', 'climbing'));

-- 이번엔 json_build_object 함수를 사용해서 users 테이블에 2명의 사용자를 추가.
-- 위에서 직접 JSON 문자열을 넣는 것과 같은 결과지만, 
-- 함수를 사용하면 더 안전하고 실수를 줄일 수 있어요.
INSERT INTO
    users (profile)
VALUES
    (
        json_build_object('name', 'Taco', 'age', 30, 'city', 'Budapest')
    ),
    (
        json_build_object(
            'name',
            'Giga',
            'age',
            25,
            'city',
            'Tbilisi',
            'hobbies',
            json_build_array('reading', 'climbing')
        )
      );

-- users 테이블에 있는 모든 사용자 정보를 조회해서 보여줘요.
-- 지금까지 추가한 모든 데이터를 확인할 수 있어요.
SELECT * FROM users;