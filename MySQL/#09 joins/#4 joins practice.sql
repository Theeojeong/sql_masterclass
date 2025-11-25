-- 문제 리스트

-- 1. 모든 개를 그들의 품종명과 함께 나열하기

SELECT
	dogs.name AS dog_name,
	breeds.name AS breed_name
FROM
	dogs
	LEFT JOIN breeds ON dogs.breed_id = breeds.breed_id;



-- 2. 개를 키우고 있는 모든 주인과 그들의 개를 같이보여주기

SELECT
	owners.name AS owner_name,
	dogs.name AS dog_name
FROM
	dogs
	JOIN owners ON dogs.owner_id = owners.owner_id;

-- 3. 모든 품종과 그 품종에 해당하는 개를 나열하기

SELECT
	breeds.name AS breed_name,
	dogs.name AS dog_name
FROM
	dogs
	RIGHT JOIN breeds ON dogs.breed_id = breeds.breed_id
	;

-- 4. 모든 개를 펫 여권 정보와 주인 정보와 함께 나열하기

SELECT
	dogs.name AS dog_name,
	pet_passport_id AS passport_id,
	owners.name AS owner_name
FROM
	dogs
	left JOIN pet_passports ON dogs.dog_id = pet_passports.dog_id
	left JOIN owners ON dogs.owner_id = owners.owner_id
	;

-- 5. 모든 재주와 그 재주를 아는 개를 나열하기
SELECT
	tricks.name,
	dogs.name
FROM
	tricks
	JOIN dog_tricks using (trick_id)
	JOIN dogs USING (dog_id);
	

-- 6. 재주를 단 한개도 알지 못하는 개를 나열하기

SELECT
	dogs.name
FROM
	dogs
	LEFT JOIN dog_tricks USING (dog_id)
WHERE
	dog_tricks.dog_id IS NULL;