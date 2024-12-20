CREATE DATABASE `fisherman`;
SHOW DATABASES;
USE `fisherman`;

CREATE TABLE `crew_members` (
    `worker_id` INT PRIMARY KEY, -- 員工編號，船長為0
    `name` VARCHAR(100) NOT NULL, -- 名
    `age` INT CHECK (age > 0 AND age <= 120), -- 年齡，正數，合理範圍1~120
    `country` VARCHAR(100) NOT NULL, -- 國籍
    `passport_number` VARCHAR(20) UNIQUE NOT NULL, -- 護照號碼，需唯一，最多20字
    `job_title` ENUM('engineer', 'fisherman', 'fish processor', 'deckhand', 'chef') NOT NULL,  -- 工種，限制為列舉選項
    `profilePhoto` MEDIUMBLOB -- 大頭照
);

CREATE TABLE `user_login` (
    `username` VARCHAR(100) NOT NULL PRIMARY KEY, -- 使用者姓名，PRIMARY KEY
    `worker_id` INT UNIQUE NOT NULL, -- 員工編號，需唯一，船長為0
    `pattern` VARCHAR(9) NOT NULL, -- 圖形登入順序，最多9字
    `role` ENUM('captain', 'fisherman') NOT NULL, -- 身分選擇，captain 或 fisherman
    `login_timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 登入時間，自動記錄當前時間
    `last_login` DATETIME, -- 上次登入時間
    `language` VARCHAR(20) DEFAULT 'en-US', -- 語言偏好，預設為 'en-US'
    `login_attempts` INT DEFAULT 0, -- 登入失敗次數，預設為 0
    CHECK (`login_attempts` >= 0),-- 登入失敗次數不可為負
    FOREIGN KEY (`worker_id`) REFERENCES `crew_members`(`worker_id`) 
	ON DELETE CASCADE
);


CREATE TABLE `work_hours` (
    `worker_id` INT NOT NULL, -- 員工編號
    `date` DATE NOT NULL, -- 日期
    `status` VARCHAR(50), -- 狀態，0=休息, 1=工作, 2=吃飯
    `duration` INT NOT NULL, -- 時長，幾個半小時
    `profilePhoto` MEDIUMBLOB NOT NULL, -- 大頭照
    `signaturePhoto` MEDIUMBLOB NOT NULL, -- 簽名照片
    `check` TINYINT(1) NOT NULL,
    `comments` VARCHAR(255) NOT NULL, -- 備註，儲存身體狀態或加班等描述
    PRIMARY KEY (`worker_id`, `date`), -- Compound Key，避免同一天重複記錄
    FOREIGN KEY (`worker_id`) REFERENCES `crew_members`(`worker_id`) -- 連結到`crew_members`表中的`worker_id`
    ON DELETE CASCADE -- 當對應的漁工刪除時，刪除相關工作時數記錄
);

-- 輸入時使用0-2表示狀態，但以文字方式儲存
DELIMITER $$
CREATE TRIGGER before_insert_work_hours
BEFORE INSERT ON work_hours
FOR EACH ROW
BEGIN
    IF NEW.status = '0' THEN
        SET NEW.status = 'resting';
    ELSEIF NEW.status = '1' THEN
        SET NEW.status = 'working';
    ELSEIF NEW.status = '2' THEN
        SET NEW.status = 'dinning';
    END IF;
END$$
DELIMITER ;

CREATE TABLE `notification` (
	`notification_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 狀態編號
    `content` TEXT, -- 通知的具體內容
    `type` varchar(30) 	DEFAULT 'Reminder' , -- 通知類型
    `status` varchar(15) NULL DEFAULT 'Unread', -- read/unread
    `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 資料插入時間
    `updateAt` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP -- 資料更新時間
);

CREATE TABLE `report`(
    `report_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 自動產生編號check
    `check` TINYINT(1) NOT NULL, -- 狀態確認
    `worker_id` INT NOT NULL, -- 員工編號
    `date` DATE NOT NULL, -- 日期
    `issue_description` TEXT NOT NULL -- 詳細問題描述
    /*FOREIGN KEY (`worker_id`) REFERENCES `crew_members`(`worker_id`) -- 連結到`crew_members`表中的`worker_id`
    ON DELETE CASCADE -- 當對應的漁工刪除時，刪除相關工作時數記錄
    worker_id設為unique的話，一張表只能出現一次*/
);

DESCRIBE `user_login`;
DESCRIBE `crew_members`;
DESCRIBE `work_hours`;
DESCRIBE `notification`;
DESCRIBE `report`;

SELECT * FROM `user_login`;
SELECT * FROM `crew_members`;
SELECT * FROM `work_hours`;
SELECT * FROM `notification`;
SELECT * FROM `report`;

DROP TABLE `user_login`;
DROP TABLE `work_hours`;
DROP TABLE `crew_members`;
DROP TABLE `notification`;
DROP TABLE `report`;
DROP DATABASE `fisherman`;
