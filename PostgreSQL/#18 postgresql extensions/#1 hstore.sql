-- key : value 데이터베이스는 key value 쌍으로 나타낼 수 있는 일종의 비구조화된, 스키마 없는 데이터를 저장할 수 있게 해준다

-- postgresql을 redis 처럼 key : value 데이터베이스로 사용할 수 있는 방법을 배운다

CREATE EXTENSION hstore;

DROP EXTENSION hstore;

CREATE TABLE hstore_users (
	user_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	prefs HSTORE
	);
	

INSERT INTO hstore_users (prefs) VALUES
('theme => dark, lang => kor, notifications => off'),
('thene => light, lang => cn, notifications => on, push_notifications => on, email_notification => off'),
('theme => dark, lang => eng, start_page => dashboard, font_size => large')
;

SELECT * FROM hstore_users;

----------------------------

SELECT
	user_id,
	prefs -> 'theme',
	prefs -> ARRAY['lang', 'notifications'],
	prefs ? 'font_size' AS has_font_size,
	prefs ?| ARRAY['push_notifications', 'start_page']
FROM
	hstore_users; -- 
	
----------------------------
SELECT
	user_id,
	akeys(prefs),
	avals(prefs)
FROM
	hstore_users;
	
----------------------------
SELECT
	user_id,
	each(prefs)
FROM
	hstore_users;
	
----------------------------

UPDATE hstore_users

SET prefs = delete(prefs, 'thene') 
           || hstore('theme', prefs->'thene')
           
WHERE user_id = 2;

----------------------------

UPDATE
	hstore_users
SET
	prefs['theme'] = 'light'
WHERE
	user_id = 1;
	
---------------------------
UPDATE
	hstore_users
SET
	prefs = prefs || hstore(
	ARRAY['currency', 'cookies_ok'],
	ARRAY['kRW', 'Yes']
	);
	
---------------------------
UPDATE
	hstore_users
SET
	prefs = DELETE(prefs, 'cookies_ok');