-- Entity = DB에 저장할 데이터의 기본 단위이며, 현실 세계 객체를 테이블로 표현한 것.
CREATE TABLE dogs (
	dog_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	breed_name VARCHAR(50) NOT NULL,
	breed_size_category ENUM('small', 'medium', 'big') DEFAULT 'small',
	breed_typical_lifespan TINYINT,
	date_of_birth DATE,
	weight DECIMAL(5,2),
	owner_name VARCHAR(50) NOT NULL,
	owner_email VARCHAR(100) UNIQUE,
	owner_phone VARCHAR(20),
	owner_address TINYTEXT
);


-- 위 dogs라는 테이블 설계는 잘못 되었고 데이터 무결성에 위반이 되는 설계이다
-- 이렇게 설계해야 한다
CREATE TABLE dogs (
	dog_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	date_of_birth DATE,
	weight DECIMAL(5,2),
	owner_id BIGINT UNSIGNED,
	breed_id BIGINT UNSIGNED
);

create table owners (
	owner_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE,
	phone VARCHAR(20),
	address TINYTEXT
);

CREATE table breeds (
	breed_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	size_category ENUM('small', 'medium', 'big') DEFAULT 'small',
	typical_lifespan TINYINT
);

-- 지금은 큰 문제가 발생할 가능성이 있는데 다음 영상에서 data를 동기화 하려면 왜 추가적인 일을 해야하는지 배운다