-- JSON 데이터를 수정하는 방법

UPDATE
	users
SET
	profile = '{"email": "N@c.c"}'; -- 이렇게 하면 profile 전체를 덮어 씌우게 된다


-- 올바른 방법은

UPDATE
	users
SET
	profile = profile || jsonb_build_object('email', 'wogusto12@naver.com');-- || 이 연산자를 사용하면 추가를 하게 된다


UPDATE
	users
SET
	profile = profile - 'email'
WHERE
	profile ->> 'name' = 'Giga'; -- Giga 이름을 가진 사람에게서 name 요소를 제거하고 싶을 때
	
	
UPDATE
	users
SET
	profile = profile || jsonb_build_object('name', 'Giga')
WHERE
	(profile ->> 'age')::INTEGER = 25; -- age가 25인 사람에게 Giga란 name을 추가해주고 싶을 때
	

UPDATE
	users
SET
	profile = profile || jsonb_build_object('hobbies', jsonb_build_array('climbing', 'watching movies'))
WHERE
	profile ->> 'name' = 'Taco'; -- name이 Taco인 사람에게 'climbing', 'watching movies' 요소를 가진 hobbies 객체를 추가해주고 싶을 때
	
UPDATE users
SET
  profile = profile || jsonb_set(
    profile,
    '{hobbies}',
    (profile -> 'hobbies') - 'climbing'
  ); -- 모든 profile의 hobbies에서 climbing 요소를 제거하고 싶을 때


UPDATE users
SET
  profile = profile || jsonb_set(
    profile,
    '{hobbies}',
    (profile -> 'hobbies') || jsonb_build_array('cooking')
  ); -- 모든 profile의 hobbies에서 cooking 요소를 추가하고 싶을 때


SELECT
	profile -> 'hobbies'
FROM
	users;