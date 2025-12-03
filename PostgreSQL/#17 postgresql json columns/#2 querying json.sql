SELECT
	profile ->> 'name' AS name,
	profile ->> 'city' AS city,
	profile ->> 'age' AS age,
	profile -> 'hobbies' ->> 0 AS hobbies
FROM
	users;
	
	
-- hobby가 있는 사람들의 name과 city만 가져오고 싶을 때

SELECT
	*
FROM
	users;

SELECT
	*
FROM
	users
WHERE
	profile ? 'hobbies'
; -- hobbies가 있는 사람을 가져오고 싶을 때

SELECT
	*
FROM
	users
WHERE
	profile -> 'hobbies' ? 'climbing'
; -- hobbies가 있는 사람 중에서 climbing이 취미인 사람을 가져오고 싶을 때

SELECT
	profile -> 'name',
	profile -> 'city',
	jsonb_array_length(profile -> 'hobbies') -- jsonb 라면 반드시 jsonb 함수를 사용해야 한다
FROM
	users;
	
	
SELECT
	profile -> 'name',
	profile -> 'city',
	jsonb_array_length(profile -> 'hobbies')
FROM
	users
WHERE
	profile ->> 'name' = 'Taco'
	; -- 이름이 Taco인 사람을 찾고 싶을 때
	

SELECT
	profile -> 'name',
	profile -> 'city',
	jsonb_array_length(profile -> 'hobbies')
FROM
	users
WHERE
	(profile ->> 'age')::INTEGER < 30
	; -- 나이가 30살 미만인 사람을 찾고 싶을 때 
	
SELECT
	profile -> 'name',
	profile -> 'city',
	jsonb_array_length(profile -> 'hobbies')
FROM
	users
WHERE
	profile -> 'hobbies' ?| ARRAY['reading', 'traveling']
	; -- reading 혹은 traveling 둘 중에 하나를 hobbies로 가지고 있는 사람을 찾고 싶을 때
	  -- | 이건 OR을 의미하고 & 이건 AND를 의미한다

SELECT
	profile -> 'name',
	profile -> 'city',
	jsonb_array_length(profile -> 'hobbies')
FROM
	users
WHERE
	profile ?& ARRAY['name', 'email']
	; -- profile에 name과 email 모두 가지고 있는 사람을 찾을 때 
	
	
SELECT
	profile -> 'name',
	profile -> 'city',
	jsonb_array_length(profile -> 'hobbies')
FROM
	users
WHERE
	profile ->> 'city' LIKE 'B%'
	; -- B로 시작하는 city를 가진 사람을 찾고 싶을 때