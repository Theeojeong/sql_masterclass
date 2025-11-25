-- 문제 리스트 

-- 1. 모든 품종과 각 품종별 개의 수
SELECT 
	breeds.name,
	count(*)
FROM
	breeds
	RIGHT JOIN dogs USING (breed_id)
GROUP BY
	breeds.name
;

-- 2. 각 주인이 키우는 개가 몇 마리인지 확인+그 개들의 평균 체중 및 평균 나이까지 확인
-- 2025년 기준 강의 수강 시, 영상에 나왔던 average_age(평균 나이)보다 1살 더 많게 나옴
SELECT
	owners.name,
	count(*),
	AVG(dogs.weight),
	AVG(TIMESTAMPDIFF(YEAR, dogs.date_of_birth, CURDATE())) AS avg_age
FROM
	owners
	LEFT JOIN dogs USING (owner_id)
GROUP BY
	owners.owner_id;

-- 3. 모든 재주와 그 해당 재주를 아는 개의 수를 인기순(많은순)으로 정렬
SELECT 
	tricks.name, 
	count(*) AS total_dogs
FROM tricks
    JOIN dog_tricks USING (trick_id)
GROUP BY 
	tricks.trick_id
ORDER BY 
	total_dogs DESC;


-- 4. 모든 개를 그들이 아는 재주 개수랑 같이 나타내기
-- COUNT(*) 대신 COUNT(dog_tricks.trick_id) as total_tricks로 하게 되면 트릭이 없는 강아지의 경우 트릭 갯수가 0으로 표시되게 됩니다.
SELECT 
	dogs.name, 
	count(*) AS known_tricks
FROM 
	dogs
    JOIN dog_tricks USING (dog_id)
GROUP BY 
	dogs.dog_id
ORDER BY 
	known_tricks DESC;

-- 5. 모든 주인을 그들의 개와 그 개가 알고 있는 재주와 함께 나열

SELECT 
	o.name, 
	d.name, 
	dt.proficiency, 
	t.`name`
FROM 
	owners o
    JOIN dogs d USING (owner_id)
    JOIN dog_tricks dt USING (dog_id)
    JOIN tricks t USING (trick_id);
