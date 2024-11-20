import mysql.connector

# 查詢漁工資料
def get_fishman_details(crew_number):
    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="P@ssw0rd",
        database="fisher_records"
    )
    cursor = connection.cursor(dictionary=True)
    sql = "SELECT * FROM fishman WHERE crew_number = %s"
    cursor.execute(sql, (crew_number,))
    result = cursor.fetchone()
    connection.close()
    return result
