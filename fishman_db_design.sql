CREATE DATABASE `fisherman_records`;
SHOW DATABASES;
USE `fisherman_records`;

CREATE TABLE `user_login` (
    `username` VARCHAR(100) NOT NULL PRIMARY KEY, -- 使用者姓名，PRIMARY KEY
    `worker_id` INT UNIQUE, -- 員工編號，需唯一，船長為NULL
    `pattern` VARCHAR(20) NOT NULL, -- 圖形登入順序，最多20字
    `role` ENUM('captain', 'fisherman') NOT NULL, -- 身分選擇，captain 或 fisherman
    `login_timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 登入時間，自動記錄當前時間
    `last_login` DATETIME, -- 上次登入時間
    `language` VARCHAR(20) DEFAULT 'en-US', -- 語言偏好，預設為 'en-US'
    `login_attempts` INT DEFAULT 0, -- 登入失敗次數，預設為 0
    CHECK (`login_attempts` >= 0) -- 登入失敗次數不可為負
);


CREATE TABLE `crew_members` (
    `worker_id` INT PRIMARY KEY, -- 員工編號
    `given_name` VARCHAR(50) NOT NULL, -- 名
    `family_name` VARCHAR(50) NOT NULL, -- 姓
    `photo` BLOB, -- 照片
    `age` INT CHECK (age > 0 AND age <= 120), -- 年齡，正數，合理範圍1~120
    `country` VARCHAR(100) NOT NULL, -- 國籍
    `passport_number` VARCHAR(20) UNIQUE NOT NULL, -- 護照號碼，需唯一，最多20字
    `job_title` ENUM('engineer', 'fisherman', 'fish processor', 'deckhand', 'cook') NOT NULL -- 工種，限制為列舉選項
);


CREATE TABLE `work_hours` (
    `worker_id` INT NOT NULL, -- 員工編號
    `date` DATE NOT NULL, -- 日期
    `status` ENUM('working', 'resting', 'dinning') NOT NULL, -- 狀態，只能選擇 working, resting, 或 dinning
    `timeStart` FLOAT NOT NULL, -- 開始時刻，單位: 小時
    `timeEnd` FLOAT NOT NULL, -- 結束時刻，單位: 小時
    `duration` FLOAT GENERATED ALWAYS AS (timeEnd - timeStart) STORED, -- 時長，根據 timeStart 和 timeEnd 自動計算
    `comments` VARCHAR(255), -- 備註，儲存身體狀態或加班等描述
    PRIMARY KEY (`worker_id`, date, `timeStart`), -- Compound Key，避免同一天、同時間重複記錄
    FOREIGN KEY (`worker_id`) REFERENCES `fishman`(`crew_number`) -- 連結到 fishman 表中的 crew_number
    ON DELETE CASCADE -- 當對應的漁工刪除時，刪除相關工作時數記錄
);

DESCRIBE `user_login`;
DESCRIBE `crew_members`;
DESCRIBE `work_hours`;

SELECT * FROM `user_login`;
SELECT * FROM `crew_members`;
SELECT * FROM `work_hours`;

# DROP TABLE `fishman`;
# DROP TABLE `user_login`;
# DROP TABLE `crew_members`;
# DROP TABLE `work_hours`;
# DROP DATABASE `fisherman_records`;
