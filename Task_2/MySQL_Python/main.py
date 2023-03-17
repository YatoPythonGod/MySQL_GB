import pymysql
from config import host, user, password, db_name

try:
    connection = pymysql.connect(
        host=host,
        port=3306,
        user=user,
        password=password,
        database=db_name,
        cursorclass=pymysql.cursors.DictCursor
    )
    print("Successfully connected...")
    try:
        with connection.cursor() as cursor:
            create_table_query = "CREATE TABLE IF NOT EXISTS python (id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(40) NOT NULL, age INT NOT NULL);"
            cursor.execute(create_table_query)
            print("Table create successfully!")

        # with connection.cursor() as cursor:
        #     insert_table_query = "INSERT INTO python (name, age) VALUES ('Ivan', 20), ('Pavel', 30);"
        #     cursor.execute(insert_table_query)
        #     connection.commit()
        #     print("Insert into the table successfully!")

        with connection.cursor() as cursor:
            select_query = "SELECT * FROM python"
            cursor.execute(select_query)
            for row in cursor.fetchall():
                print(row)


    finally:
        connection.close()
except Exception as e:
    print("Connection refused...")
    print(e)
