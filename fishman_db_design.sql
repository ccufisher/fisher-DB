CREATE DATABASE `fisher_records`;
SHOW DATABASES;
USE `fisher_records`;

CREATE TABLE `branch` (
    `branch_id` INT PRIMARY KEY,
    `branch_name` VARCHAR(20)
);

CREATE TABLE `fishman` (
    `crew_number` INT PRIMARY KEY NOT NULL, 
    `name` VARCHAR(100) NOT NULL,
    `photo` BLOB,
    `country_of_citizenship` VARCHAR(100),
    `passport_number` VARCHAR(20),
    `age` INT,
    `working_hours` INT DEFAULT 0,
    `branch_id` INT,
    FOREIGN KEY (`branch_id`) REFERENCES `branch`(`branch_id`)
);

INSERT INTO `branch` VALUES(1, 'Captain');
INSERT INTO `branch` VALUES(2, 'Fisherman');
INSERT INTO `branch` VALUES(3, 'Deckhands');
INSERT INTO `branch` VALUES(4, 'Fish Processors');
INSERT INTO `branch` VALUES(5, 'Engineers');
INSERT INTO `branch` VALUES(6, 'Cook');


DESCRIBE `fishman`;
DESCRIBE `branch`;
SELECT * FROM `fishman`;
SELECT * FROM `branch`;
# DROP TABLE `fishman`;
# DROP TABLE `branch`;
# DROP DATABASE `fisher_records`;
