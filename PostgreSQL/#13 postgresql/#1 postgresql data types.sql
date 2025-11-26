CREATE TYPE gender_type AS ENUM ('male', 'female');

CREATE TABLE users (

	username CHAR(10) NOT NULL UNIQUE,
	email VARCHAR(50) NOT NULL UNIQUE,
	
	gender gender_type NOT NULL,
	interests TEXT[] NOT NULL, -- MySQL의 SET을 따라하는 방법
	bio TEXT NOT NULL, -- pg에는 tinytext, mediumtext, longtext없이 text만 있다
	-- maximum size =1 GB
	-- pg는 기본적으로 입력받은 긴 텍스트를 압축한다
	-- 만약 텍스트가 너무 길어서 압축했는데도 2KB보다 크다면 텍스트는 다른 곳으로 옮겨진다
	-- 긴 텍스트가 실제로는 다른 테이블 어딘가에 저장이 된다
	-- 그리고 그 테이블(row)를 가리키는 포인터가 생긴다
	-- pg에서는 이걸 TOAST(Oversized-Attribute Storage Technique)라고 부른다
	profile_photo BYTEA, --BYTEA(Byte Array), 최대 1GB 이진 데이터를 저장 한다
	-- 만약 pg에 더 큰 파일을 저장하고 싶으면 Large Object API가 필요하다
	-- 하지만 파일을 데이터베이스에 저장하는 걸 추천하지 않는다
	-- 스토리지 버킷에 저장하고 URL만 저장하는게 더 좋다
	age SMALLINT NOT NULL CHECK (age >= 0),
	-- SMALLINT
	-- Signed: -32,768 to 32,767
	
	-- INTGER
	-- Signed: -2,147,483,648 to 2,147,483,647
	
	-- BIGINT
	-- Signed: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
	
	-- SMALLSERIAL (1 to 32,767) -- SERIAL: Auto-Increment가 된다는 뜻
	-- SERIAL (1 to 2,147,483,647)
	-- BIGSERIAL (1 to 9,223,372,036,854,775,807)
	
	-- DECIMAL & NUMERIC(precision, scale) 10.53 4p 2s
	-- REAL (6 deciaml digits) & DOUBLE PRECISION (15 decimal digits)
	
	is_admin BOOLEAN NOT NULL DEFAULT FALSE,
	joined_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, -- TIMESTAMPTZ = TIMESTAMP WITH TIME ZONE
						  									  -- 4713 BC to 294276 AD
	updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
	birth_date DATE NOT NULL,
	bed_time TIME NOT NULL,
	graduation_year INTEGER NOT NULL CHECK (graduation_year BETWEEN 1901 AND 2115),
	internship_period INTERVAL
	);