-- Create tables
CREATE TABLE dogs (
dog_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
weight DECIMAL(5,2),
date_of_birth DATE,
owner_id BIGINT UNSIGNED,
breed_id BIGINT UNSIGNED,
FOREIGN KEY (owner_id) REFERENCES owners (owner_id) ON DELETE SET NULL,
CONSTRAINT breed_fk FOREIGN KEY (breed_id) REFERENCES breeds (breed_id) ON DELETE SET NULL
);


CREATE TABLE owners (
owner_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE,
phone VARCHAR(20),
address TINYTEXT
);


CREATE TABLE breeds (
breed_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
size_category ENUM ('small', 'medium', 'big') DEFAULT 'small',
typical_lifespan TINYINT
);


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
proficiency ENUM('beginner', 'intermediate', 'expert') NOT NULL DEFAULT 'beginner',
date_learned TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (dog_id, trick_id),
FOREIGN KEY (dog_id) REFERENCES dogs (dog_id) ON DELETE CASCADE,
FOREIGN KEY (trick_id) REFERENCES tricks (trick_id) ON DELETE CASCADE
);


-- INSERT
INSERT INTO breeds (name, size_category, typical_lifespan) VALUES
('Labrador Retriever', 'big', 12),
('German Shepherd', 'big', 11),
('Golden Retriever', 'big', 11),
('French Bulldog', 'small', 10),
('Beagle', 'medium', 13),
('Poodle', 'medium', 14),
('Chihuahua', 'small', 15);


INSERT INTO owners (name, email, phone, address) VALUES
('John Doe', 'john@example.com', '123-456-7890', '123 Main St, Anytown, USA'), ('Jane Smith', 'jane@example.com', '234-567-8901', '456 Elm St, Someplace, USA'), ('Bob Johnson', 'bob@example.com', '345-678-9012', '789 Oak St, Elsewhere, USA'), ('Alice Brown', 'alice@example.com', '456-789-0123', '321 Pine St, Nowhere, USA'), ('Charlie Davis', 'charlie@example.com', '567-890-1234', '654 Maple St, Somewhere, USA'), ('Eva Wilson', 'eva@example.com', '678-901-2345', '987 Cedar St, Anyville, USA'), ('Frank Miller', 'frank@example.com', '789-012-3456', '246 Birch St, Otherville, USA'), ('Grace Lee', 'grace@example.com', '890-123-4567', '135 Walnut St, Hereville, USA'), ('Henry Taylor', 'henry@example.com', '901-234-5678', '864 Spruce St, Thereville, USA'), ('Ivy Martinez', 'ivy@example.com', '012-345-6789', '753 Ash St, Whereville, USA'), ('Jack Robinson', 'jack@example.com', '123-234-3456', '951 Fir St, Thatville, USA'), ('Kate Anderson', 'kate@example.com', '234-345-4567', '159 Redwood St, Thisville, USA');


INSERT INTO dogs (name, date_of_birth, weight, breed_id, owner_id) VALUES
('Max', '2018-06-15', 30.5, 1, 1),
('Bella', '2019-03-22', 25.0, NULL, 2),
('Charlie', '2017-11-08', 28.7, 2, 3),
('Lucy', '2020-01-30', 8.2, NULL, NULL),
('Cooper', '2019-09-12', 22.3, 5, 5),
('Luna', '2018-07-05', 18.6, 6, 6),
('Buddy', '2016-12-10', 31.2, 1, 7),
('Daisy', '2020-05-18', 6.8, NULL, 8),
('Rocky', '2017-08-25', 29.5, 2, 9),
('Molly', '2019-11-03', 24.8, 3, NULL),
('Bailey', '2018-02-14', 21.5, 5, 11),
('Lola', '2020-03-27', 7.5, 4, 12),
('Duke', '2017-05-09', 32.0, NULL, 1),
('Zoe', '2019-08-11', 17.8, 6, 2),
('Jack', '2018-10-20', 23.6, NULL, 3),
('Sadie', '2020-02-05', 26.3, 3, 4),
('Toby', '2017-07-17', 8.9, 7, NULL),
('Chloe', '2019-04-30', 20.1, 6, 6),
('Bear', '2018-01-08', 33.5, 2, 7),
('Penny', '2020-06-22', 7.2, 4, NULL);


INSERT INTO tricks (name, difficulty) VALUES
('Sit', 'easy'),
('Stay', 'medium'),
('Fetch', 'easy'),
('Roll Over', 'hard'),
('Shake Hands', 'medium');


INSERT INTO dog_tricks (dog_id, trick_id, proficiency, date_learned) VALUES
(1, 1, 'expert', '2019-01-15'),
(1, 2, 'intermediate', '2019-03-20'),
(14, 3, 'expert', '2019-02-10'),
(2, 1, 'expert', '2019-07-05'),
(2, 3, 'intermediate', '2019-08-12'),
(3, 1, 'expert', '2018-03-10'),
(3, 2, 'expert', '2018-05-22'),
(13, 4, 'beginner', '2019-11-30'),
(4, 1, 'intermediate', '2020-05-18'),
(5, 1, 'expert', '2020-01-07'),
(11, 3, 'expert', '2020-02-15'),
(5, 5, 'intermediate', '2020-04-22'),
(7, 1, 'expert', '2017-06-30'),
(7, 2, 'expert', '2017-08-14'),
(12, 3, 'expert', '2017-07-22'),
(16, 4, 'intermediate', '2018-01-05'),
(7, 5, 'expert', '2017-09-18'),
(10, 1, 'intermediate', '2020-03-12'),
(10, 3, 'beginner', '2020-05-01'),
(15, 1, 'expert', '2019-02-28'),
(14, 2, 'intermediate', '2019-04-15'),
(18, 1, 'intermediate', '2019-09-10'),
(18, 5, 'beginner', '2020-01-20');


INSERT INTO pet_passports (dog_id, blood_type, allergies, last_checkup_date) VALUES
(1, 'DEA 1.1+', 'None', '2023-01-05'),
(2, 'DEA 1.1-', 'Chicken', '2023-02-22'),
(3, 'DEA 4+', 'None', '2023-03-08'),
(5, 'DEA 7+', 'Beef', '2023-04-12'),
(7, 'DEA 1.1+', 'None', '2023-01-10'),
(10, 'DEA 3-', 'Dairy', '2023-05-03'),
(12, 'DEA 5-', 'None', '2023-03-27'),
(15, 'DEA 1.1-', 'Grains', '2023-04-20'),
(18, 'DEA 7+', 'None', '2023-04-03'),
(20, 'DEA 4+', 'Pollen', '2023-06-22');,