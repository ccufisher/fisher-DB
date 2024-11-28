-- 使用 fisheraman_records 資料庫
USE `fisherman_records`;

-- 測試 crew_members 表格
INSERT INTO `crew_members` (`worker_id`, `given_name`, `family_name`, `photo`, `age`, `country`, `passport_number`, `job_title`)
VALUES (1, 'John', 'Doe', LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\jane.png'),  30, 'USA', 'USA1234567890', 'engineer'),
       (2, 'Jane', 'Smith', LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\jane.png'), 25, 'Canada', 'CAN1234567890', 'fisherman');
-- LOAD_FILE中的路徑為圖片儲存位置
SELECT * FROM `crew_members`;

-- 測試 user_login 表格
INSERT INTO `user_login` (`username`, `worker_id`, `pattern`, `role`, `login_timestamp`, `last_login`, `language`, `login_attempts`)
VALUES ('johndoe', 1, '1234', 'captain', NOW(), NULL, 'en-US', 0),
       ('janesmith', 2, '4321', 'fisherman', NOW(), NULL, 'en-US', 0);

SELECT * FROM `user_login`;


-- 測試 work_hours 表格
INSERT INTO `work_hours` (`worker_id`, `date`, `status`, `timeStart`, `timeEnd`, `comments`)
VALUES (1, '2024-11-27', 'working', 8.0, 12.0, 'Normal shift'),
       (2, '2024-11-27', 'resting', 12.0, 14.0, 'Lunch break');

-- 檢查 work_hours 表格資料是否插入成功
SELECT * FROM `work_hours`;

-- 測試資料刪除 (刪除用戶 jonesmith 和對應的工作時數)
DELETE FROM `user_login` WHERE `username` = 'janesmith';
DELETE FROM `work_hours` WHERE `worker_id` = 2;

SELECT * FROM `user_login`;
SELECT * FROM `work_hours`;

-- 測試資料刪除（刪除整個 crew_members 資料）
DELETE FROM `crew_members` WHERE `worker_id` = 1;

SELECT * FROM `crew_members`;
#SELECT worker_id, LENGTH(photo) AS photo_size FROM crew_members; 可透過輸出圖片大小來檢測圖片是否載入完全

-- 清除測試資料
DROP TABLE IF EXISTS `work_hours`;
DROP TABLE IF EXISTS `user_login`;
DROP TABLE IF EXISTS `crew_members`;

-- 刪除測試資料庫
DROP DATABASE `fisherman_records`;
