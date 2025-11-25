-- one to many
FOREIGN key를 사용해서 table간 entity를 연결하기 시작할 때

여러분이 다른 table의 column을 참조하기 시작할 때

data를 연결하게 되고 이는 data간 relationship을 만든다

우리는 owners table 그리고 breeds table과 연결된 dogs table이 있었다

이건 1:N 혹은 N:1 관계를 만든다

breeds table에 비글이 있다고 하자

하나의 견종, 비글은 여러 마리의 강아지와 연결될 수 있다

이 말은 breeds는 dogs table과 1:N 관계를 가진단 뜻이다

하나의 견종은 여러 마리의 강아지와 연결될 수 있기 때문이다

dogs table의 입장에서 보자면 강아지는 하나의 견종만 가질 수 있다

그러나 여러 마리의 강아지는 같은 견종일 수 있다

이제 owner의 입장에서 보자면

한 명의 주인은 여러 마리의 강아지를 가질 수 있다

1:N 관계를 의미한다, 하나의 주인과 여러 마리의 강아지

강아지는 오직 한 명의 주인만을 가진다

하지만 여러 마리의 강아지는 동일한 주인에게 연결될 수 있다

따라서 owners table은 dogs table과 1:N 관계를 가지고

dog table은 N:1 관계를 가진다

-- one-to-one

CREATE TABLE dogs_passports (
	dog_passport_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	blood_type VARCHAR(10),
	allergies TEXT,
	last_checkup_date DATE,
	dog_id BIGINT UNSIGNED UNIQUE, -- UNIQUE 조건으로 1:1 관계가 성립된다
	FOREIGN KEY (dog_id) REFERENCES dogs (dog_id) ON DELETE CASCADE
);


1. One-To-Many (1:N) 관계
	한 테이블의 하나의 레코드가, 다른 테이블의 여러 레코드와 연결되는 관계
	(1:N은 외래 키만 있으면 표현 가능)
	ex) 한 명의 주인은 여러 마리 강아지를 가질 수 있다.

2. One-To-One (1:1) 관계
	두 테이블 사이에서, 하나의 레코드가 다른 테이블의 오직 하나의 레코드와만 연결되는 관계
	(1:1은 외래 키 + UNIQUE 조건이 있어야 강제 가능)
	ex) 한 마리의 강아지는 하나의 여권만 가질 수 있다.

DB 다이어그램
https://dbdiagram.io