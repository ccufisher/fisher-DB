import mysql.connector

# 資料庫
def create_database():
    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="P@ssw0rd"
    )
    cursor = connection.cursor()
    cursor.execute("CREATE DATABASE IF NOT EXISTS fisher_records")
    connection.close()

# 資料表&初始資料
def create_tables():
    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="P@ssw0rd",
        database="fisher_records"
    )
    cursor = connection.cursor()

    # 建立branch表
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS branch (
        branch_id INT PRIMARY KEY,
        branch_name VARCHAR(20)
    )
    """)

    # 建立fishman表
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS fishman (
        crew_number INT PRIMARY KEY NOT NULL,
        name VARCHAR(100) NOT NULL,
        photo BLOB,
        country_of_citizenship VARCHAR(100),
        passport_number INT,
        age INT,
        working_hours INT DEFAULT 0,
        branch_id INT,
        FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
    )
    """)

    initial_branches = [
        (1, 'Captain'), (2, 'Fisherman'), (3, 'Deckhands'),
        (4, 'Fish Processors'), (5, 'Engineers'), (6, 'Cook')
    ]
    cursor.executemany(
        "INSERT INTO branch (branch_id, branch_name) VALUES (%s, %s) ON DUPLICATE KEY UPDATE branch_id=branch_id",
        initial_branches
    )

    connection.commit()
    connection.close()

if __name__ == "__main__":
    # 執行資料庫與表的建立
    create_database()
    create_tables()