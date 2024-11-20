import mysql.connector

# 區塊功能：更新工作時數
def update_working_hours(crew_number, hours):
    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="P@ssw0rd",
        database="fisher_records"
    )
    cursor = connection.cursor()
    sql = "UPDATE fishman SET working_hours = working_hours + %s WHERE crew_number = %s"
    cursor.execute(sql, (hours, crew_number))
    connection.commit()
    connection.close()
