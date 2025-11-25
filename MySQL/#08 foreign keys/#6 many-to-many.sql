-- N:N 관계를 구현해볼 것

drop table owners;

CREATE TABLE pet_passports (
    pet_passport_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    blood_type VARCHAR(10),
    allergies TEXT,
    last_checkup_date DATE,
    dog_id BIGINT UNSIGNED UNIQUE,
    FOREIGN KEY (dog_id) REFERENCES dogs (dog_id) ON DELETE CASCADE
);

CREATE TABLE tricks (
    trick_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    difficulty ENUM('easy', 'medium', 'hard') NOT NULL DEFAULT 'easy'
);


CREATE TABLE dog_tricks (
	dog_id BIGINT UNSIGNED,
	trick_id BIGINT UNSIGNED,
	proficiency ENUM("beginner", "intermediate", "expert") NOT NULL DEFAULT "beginner",
	date_learned TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (dog_id, trick_id),
	FOREIGN KEY (dog_id) REFERENCES dogs (dog_id) ON DELETE CASCADE,
	FOREIGN KEY (trick_id) REFERENCES tricks (trick_id) ON DELETE CASCADE
);


INSERT INTO tricks (name) VALUES ('앉기');

INSERT INTO dog_tricks (dog_id, trick_id) VALUES (3, 1);

SELECT * from dog_tricks;

-- bridge나 link table 없이 N:N 관계를 표현하는 것은 불가능 하다


✅ Many-to-Many(다대다)
: 한 마리의 강아지(dogs)가 여러 개의 재주(tricks)를 배울 수 있고, 반대로 한 재주(tricks)도 여러 마리의 강아지가 배울 수 있습니다. 이처럼 양쪽 모두 "여러 개"를 가질 수 있는 관계를 다대다 관계라고 합니다.

✅ 그런데 SQL(관계형 DB)은 다대다를 직접 만들 수 없음!
SQL은 직접적으로 다대다 관계를 정의할 수 없어서, 중간 테이블(dog_tricks)을 만들어야 합니다.