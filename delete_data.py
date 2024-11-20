import mysql.connector

# 檢查Captain權限
def is_captain(branch_id):
    return branch_id == 1

# 刪除漁工資料
def delete_fishman(crew_number, branch_id):
    if not is_captain(branch_id):
        print("Permission denied: Only Captain can delete fishman data.")
        return

    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="P@ssw0rd",
        database="fisher_records"
    )
    cursor = connection.cursor()
    sql = "DELETE FROM fishman WHERE crew_number = %s"
    cursor.execute(sql, (crew_number,))
    connection.commit()
    connection.close()

# 刪除工種類別
def delete_branch(branch_id_to_delete, branch_id):
    if not is_captain(branch_id):
        print("Permission denied: Only Captain can delete branch.")
        return

    connection = mysql.connector.connect(
        host="localhost",
        user="root",
        password="your_password",
        database="fisher_records"
    )
    cursor = connection.cursor()
    sql = "DELETE FROM branch WHERE branch_id = %s"
    cursor.execute(sql, (branch_id_to_delete,))
    connection.commit()
    connection.close()
