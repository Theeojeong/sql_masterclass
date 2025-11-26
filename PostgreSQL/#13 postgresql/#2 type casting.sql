INSERT INTO users (
    username,
    email,
    gender,
    interests,
    bio,
    age,
    is_admin,
    birth_date,
    bed_time,
    graduation_year,
    internship_period
) VALUES (
    'theo',
    'wogusto13@gmail.com',
    'male',
    ARRAY['tech', 'music', 'travel'],
    'i like eating and traveling',
    18,
    TRUE,
    '1999-10-02',
    '21:00:00',
    2025,
    '2 years 6 months'
);


SELECT joined_at from users;

SELECT joined_at::date from users; -- 이렇게 date만 추출할 수 있음
SELECT joined_at::time from users; -- 이렇게 time만 추출할 수 있음


SELECT
	joined_at::date AS joined_date,
	EXTRACT(YEAR FROM joined_at) AS joined_year,
	joined_at - INTERVAL '1 day' AS day_before_joining,
	AGE(birth_date) AS age,
	justify_interval(INTERVAL '38493 hours') -- 입력된 값을 년, 월, 일, 시간으로 변환 해준다
FROM
	users;
	
drop table users;
	