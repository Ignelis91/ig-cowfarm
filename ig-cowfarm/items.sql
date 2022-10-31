INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES 
    ('milk', 'Milk', 1, 0, 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('farmer', 'Melžejas')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('farmer', 0, 'farmer', 'Darbuotojas', 0, '{}', '{}')
;
