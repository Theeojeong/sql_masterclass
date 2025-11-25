-- foreign key 제약을 만들었기 때문에 참조하는 레코드가 삭제되거나 업데이트 될 때 어떤 일이 일어날지 처리해야 한다

drop table dogs;

CREATE TABLE dogs (
	dog_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	date_of_birth DATE,
	weight DECIMAL(5,2),
	owner_id BIGINT UNSIGNED,
	breed_id BIGINT UNSIGNED,
	FOREIGN KEY (owner_id) REFERENCES owners (owner_id),
	FOREIGN KEY (breed_id) REFERENCES breeds (breed_id)
);

 DELETE FROM owners where owner_id = 1;
 -- 위 쿼리를 실행 하면 오류가 발생한다
 -- 왜냐하면 dogs 테이블의 owner_id가 owners 테이블의 owner_id 를 참조하고 있기 때문이다
 
 -- 그래서 foreign key 제약을 만들 때 참조된 row가 삭제될 때 어떻게 할 건지 지정해야한다
 
 CREATE TABLE dogs (
	dog_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	date_of_birth DATE,
	weight DECIMAL(5,2),
	owner_id BIGINT UNSIGNED,
	breed_id BIGINT UNSIGNED DEFAULT 2,
	FOREIGN KEY (owner_id) REFERENCES owners (owner_id) ON DELETE SET NULL, -- CASCADE는 관련된 record가 삭제되면, 그것과 연결된 다른 레코드도 삭제되는 것을 의미한다.
	-- 즉 주인이 삭제되면 강아지도 삭제된다
	-- 혹은 ON DELETE SET NULL 로 설정할 수 있다.
	-- SET NULL은 dogs 테이블의 owner_id column을 NULL로 설정하고 싶다는 의미다
	-- ON UPDATE도 가능하다
	-- owner_id가 업데이트 되는 경우가 매우 적지만 on update도 가능하다
	FOREIGN KEY (breed_id) REFERENCES breeds (breed_id) ON DELETE SET DEFAULT -- 이거는 dreed_id가 삭제되면 기본값으로 변경된다는 의미
);



alter table dogs add CONSTRAINT owner_fk FOREIGN key (owner_id) REFERENCES owners (owner_id) ON DELETE set null;

alter table dogs drop FOREIGN key owner_fk;
-- 이렇게 table을 삭제하지 않고 수정 가능

INSERT INTO
	dogs (name, date_of_birth, weight, breed_id, owner_id)
VALUES
	('Champ', '2018-03-15', 10.5, 1, 1);
	
DELETE FROM owners where owner_id = 1;