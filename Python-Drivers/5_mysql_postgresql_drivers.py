# MySQL과 PostgreSQL은 python의 specification을 implement 했기 때문에
# 이전에 배운 것으로 그대로 사용하면 된다

# PostgreSQL 예시(자세한건 공식 문서 참조)
import psycopg2

with psycopg2.connect("dbname=test user=postgres") as conn:

    with conn.cursor() as cur:

        cur.execute("""
            CREATE TABLE test (
                id serial PRIMARY KEY,
                num integer,
                data text            
            )
        """)

        cur.execute(
            "INSERT INTO test (num, data) VALUES (%s, %s)", # ps에서는 ?를 사용하지 않는다
            (100, "adc'def")
        )

        cur.execute("SELECT * FROM test")
        cur.fetchone()

        for record in cur:
            print(record)

        conn.commit()


# MySQL 예시(자세한건 공식 문서 참조)
import mysql.connector
from mysql.connector import errorcode

try:
    cnx = mysql.connector.connect(user="scott", database="employ")
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Something is wrong with your user name or password")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    else:
        print(err)
else:
    cnx.close()
