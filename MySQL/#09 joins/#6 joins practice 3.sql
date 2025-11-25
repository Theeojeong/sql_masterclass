-- 문제 리스트

-- 1. Show all breeds with their average dog weight and typical lifespan
SELECT
    breeds.name,
    avg(dogs.weight),
    breeds.typical_lifespan
FROM breeds
    JOIN dogs USING (breed_id)
GROUP BY breeds.breed_id;


-- 2. Display all dogs with their latest checkup date and the time since their last checkup
SELECT
    dogs.name,
    pet_passports.last_checkup_date,
    TIMESTAMPDIFF(DAY, pet_passports.last_checkup_date, CURDATE())
FROM dogs
    JOIN pet_passports USING (dog_id);

-- 3. Display all breeds with the name of the heaviest dog of that breed
SELECT 
	breeds.breed_id,
    breeds.name,
    dogs.name,
    dogs.weight
FROM breeds
	JOIN dogs USING (breed_id)
WHERE 
    dogs.weight = (
        SELECT 
            max(d1.weight)
        FROM 
            dogs d1
        WHERE 
            d1.breed_id = breeds.breed_id
    );

-- 4. List all tricks with the name of the dog who learned it most recently

SELECT
	tricks.name,
	dogs.name,
	dog_tricks.date_learned
FROM
	tricks
	JOIN dog_tricks USING (trick_id)
	JOIN dogs USING (dog_id)
WHERE
	dog_tricks.date_learned = (
		SELECT
			MAX(dt.date_learned)
		FROM
			dog_tricks dt
		WHERE
			dt.trick_id = tricks.trick_id);
-- not necessary GROUP BY trick_id);