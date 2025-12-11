# Python에서 SQLite, MySQL, PostgreSQL 데이터베이스와 소통할 때
# INSERT 명령어를 실행하면 Transaction이 열린다
# 따라서 반드시 commit을 해야한다

import sqlite3

conn = sqlite3.connect('user-db')

corsur = conn.cursor()

def init_table():
    corsur.execute("""
        CREATE TABLE users (
            user_id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            password TEXT NOT NULL
        );
    """)

    corsur.execute("""
        INSERT INTO users (name, password)
        VALUES ('jaehyeon', 'kjs1673'), ('seohyun', '1673');
    """)


def print_all_users():
    res = corsur.execute("""SELECT * FROM users""")
    data = res.fetchall()

    print(data)

init_table()

print_all_users()  

conn.commit()
conn.close()
