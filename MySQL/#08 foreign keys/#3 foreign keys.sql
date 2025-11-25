drop table dogs;

CREATE TABLE dogs (
	dog_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	date_of_birth DATE,
	weight DECIMAL(5,2),
	owner_id BIGINT UNSIGNED,
	breed_id BIGINT UNSIGNED,
	FOREIGN KEY (owner_id) REFERENCES owners (owner_id),
	FOREIGN KEY (breed_id) REFERENCES breeds (breed_id) -- 제약 조건에 이름을 붙이고 싶다면 앞에 CONSTRAINT 변수명을 추가
);

INSERT INTO
	breeds (name, size_category, typical_lifespan)
VALUES
	('Golden Retriever', 'big', 12);
	
INSERT INTO
	owners (name, email, phone, address)
VALUES
(
	'Adam Smith',
	'adam@smith.com',
	'1122334455',
	'9010 St. Scotland'
);

INSERT INTO
	dogs (name, date_of_birth, weight, breed_id, owner_id)
VALUES
	('Champ', '2018-03-15', 10.5, 1, 1);

-- 지금 우리는 데이터 일관성이 없다, 왜냐하면 breed_id=6과 owner_id=7은 존재하지 않기 때문이다
-- 이때 foreign key 제약의 개념이 필요하다

-- 참조하는 table에 없는 값을 사용하는 경우로 부터 보호하는 것이다
-- 이게 바로 foreign key 제약이다

-- 따라서 우리는 dogs table을 drop시켜야 한다


