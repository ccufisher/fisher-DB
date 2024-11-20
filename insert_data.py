import mysql.connector

# 插入新漁工資料
def insert_fishman(crew_number, name, country, passport, age, branch_id):
    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="P@ssw0rd",
        database="fisher_records"
    )
    cursor = connection.cursor()
    sql = """
    INSERT INTO fishman (crew_number, name, country_of_citizenship, passport_number, age, branch_id)
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    cursor.execute(sql, (crew_number, name, country, passport, age, branch_id))
    connection.commit()
    connection.close()
