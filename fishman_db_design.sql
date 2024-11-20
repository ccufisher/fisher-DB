CREATE TABLE `fishman`(
    `crew_number` INT PRIMARY KEY NOT NULL, 
    `name` VARCHAR(100) NOT NULL,
    `photo` BLOB,
    `country_of_citizenship` VARCHAR(100),
    `passport_number` INT,
    `age` INT,
    `working_hours` INT DEFAULT '0',
    `branch_id` INT,
);

CREATE TABLE `branch`(
	`branch_id` INT PRIMARY KEY,
    `branch_name` VARCHAR(20),
);

ALTER TABLE `fishman`
ADD FOREIGN KEY(`branch_id`)
REFERENCES `branch`(`branch_id`)
ON DELETE SET NULL;

INSERT INTO `branch` VALUES(1, 'Captain', NULL);
INSERT INTO `branch` VALUES(2, 'Fisherman', NULL);
INSERT INTO `branch` VALUES(3, 'Deckhands', NULL);
INSERT INTO `branch` VALUES(4, 'Fish Processors', NULL);
INSERT INTO `branch` VALUES(5, 'Engineers', NULL);
INSERT INTO `branch` VALUES(6, 'Cook', NULL);