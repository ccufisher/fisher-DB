-- 使用 fisheraman_records 資料庫
USE `fisherman_records`;

-- 測試 crew_members 表格
INSERT INTO `crew_members` (`worker_id`, `name`, `age`, `country`, `passport_number`, `job_title`, `profilePhoto`)
VALUES (1, 'JohnDoe', 30, 'USA', 'USA1234567890', 'engineer', LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\janee.jpg')),
       (2, 'JaneSmith',  25, 'Canada', 'CAN1234567890', 'fisherman', LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\janee.jpg'));
-- LOAD_FILE中的路徑為圖片儲存位置
SELECT * FROM `crew_members`;

-- 測試 user_login 表格
INSERT INTO `user_login` (`username`, `worker_id`, `pattern`, `role`, `login_timestamp`, `last_login`, `language`, `login_attempts`)
VALUES ('johndoe', 1, '1234', 'captain', NOW(), NULL, 'en-US', 0),
       ('janesmith', 2, '4321', 'fisherman', NOW(), NULL, 'en-US', 0);

SELECT * FROM `user_login`;


-- 測試 work_hours 表格
INSERT INTO `work_hours` (`worker_id`, `date`, `status`, `duration`, `profilePhoto`, `signaturePhoto`, `check`, `comments`)
VALUES (1, '2024-11-27', '1', 5, LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\janee.jpg'), 
								 LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\janee.jpg'), 1, 'Normal shift'),
       (2, '2024-11-27', '0', 12, LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\janee.jpg'), 
                                  LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\janee.jpg'), 0, 'Lunch break');

-- 測試 notification 表格
INSERT INTO `notification` (`content`, `type`, `status`, `createdAt`, `updateAt`)
VALUES ('Worker Tuang Hee has worked overtime for 100 hours on 12/27/2024', 'Reminder', 'Read', now(), now()),
       ('Worker Jake has worked overtime for 10 hours on 11/15/2024', 'Reminder', 'Unread', now(), now());


-- 測試 report 表格
INSERT INTO `report` (`check`, `worker_id`, `date`, `issue_description`)
VALUES (1, 1, '2024-11-27', 'wrong working time'),
       (0, 2, '2024-11-25', 'Error in meal time registration'),
       (0, 1, '2024-11-27', 'wrong working time');

-- 檢查 work_hours 表格資料是否插入成功
SELECT * FROM `work_hours`;

-- 測試資料刪除 (刪除用戶 jonesmith 和對應的工作時數)
DELETE FROM `user_login` WHERE `username` = 'JaneSmith';
DELETE FROM `work_hours` WHERE `worker_id` = 2;

SELECT * FROM `user_login`;
SELECT * FROM `work_hours`;
SELECT * FROM `notification`;
SELECT * FROM `report`;

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

