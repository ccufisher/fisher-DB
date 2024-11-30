# Fishman roll call records
目前資料庫規劃：

## 新增船員資料 `crew_members`
![crew_members](https://github.com/user-attachments/assets/ce2343f5-4639-4a7b-b6bf-93db9915a94a)

## 船長/漁工登入 `user_login`
![user_login](https://github.com/user-attachments/assets/c52efd12-3191-4470-8b03-0df023cc067e)

## 登記時數 `work_hours`
![work_hours](https://github.com/user-attachments/assets/354f84fb-b52c-4d20-8c61-72ddda2abf51)


## 通知表 ‵notification`
![notification](https://github.com/user-attachments/assets/92ae554a-2b54-4e2f-956a-d58f3d4e9e58)


## testfile
1. 把fishman_db_design中最後面的drop table/database都註解掉
   維持database開啟中的狀態
2. 執行test file即可看見資料庫的輸出

### 需要注意的部分:
1. photo在輸出時會顯示BOLB而非圖片本身
   為SQL用於存儲二進制數據（例如圖片、文件等）的數據類型
2. 目前還沒辦法測試上次登入時間和登入失敗次數
   因為那些功能可能要與後端的程式做整合後才能實行
