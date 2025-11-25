-- 대부분의 경우 cross join 대신 inner join을 사용하게 될 것이다

SELECT * FROM dogs INNER JOIN owners; -- inner join = join
-- =

SELECT
 	dogs.name AS dog_name,
 	owners.name AS owner_name,
 	breeds.name AS breed_name
FROM 
	dogs  
	JOIN owners ON dogs.owner_id = owners.owner_id
	JOIN breeds ON dogs.breed_id = breeds.breed_id;

-- ON dogs.breed_id = breeds.breed_id -> USING (breed_id)

SELECT
 	dogs.name AS dog_name,
 	owners.name AS owner_name,
 	breeds.name AS breed_name
FROM 
	dogs  
	JOIN owners USING (owner_id)
	JOIN breeds USING (breed_id);
	
	

-- ON 으로 조건을 작성하지 않으면 cross join이 실행된다

INNER JOIN은 "공통된 것만" 연결하는 겁니다!

직관적 이해: "교집합" 또는 "매칭되는 것만"이라고 생각하면 돼요.

실무에서 그냥 "JOIN"이라고 쓰면 보통 INNER JOIN을 의미해요!