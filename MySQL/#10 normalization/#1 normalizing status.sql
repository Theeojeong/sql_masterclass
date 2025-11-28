insert into statuses (status_name) SELECT status FROM movies GROUP BY status;

alter table movies add column status_id BIGINT unsigned;

alter table movies add CONSTRAINT fk_status FOREIGN key (status_id) REFERENCES statuses (status_id) on DELETE set null;

update movies set status_id = (SELECT status_id FROM statuses WHERE status_name = movies.status);

SELECT
	status_id
FROM
	statuses
WHERE
	status_name = movies.status
	;

CREATE TABLE statuses (
	status_id BIGINT unsigned PRIMARY KEY AUTO_INCREMENT,
	status_name ENUM (
	'Cancled',
	'In Production',
	'Planned',
	'Post Production',
	'Released',
	'Rumored'
	) Not NUll,
	explaination TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP not null,
	updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE statuses MODIFY status_name ENUM (
	'Canceled',
	'In Production',
	'Planned',
	'Post Production',
	'Released',
	'Rumored'
	) Not NUll;

SELECT
	status
FROM
	movies
GROUP BY
	status;