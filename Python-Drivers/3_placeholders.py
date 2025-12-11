import sqlite3

conn = sqlite3.connect("user-db")

corsur = conn.cursor()


def init_table():
    corsur.execute(
        """
        CREATE TABLE users (
            user_id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            password TEXT NOT NULL
        );
    """
    )

    corsur.execute(
        """
        INSERT INTO users (name, password)
        VALUES ('jaehyeon', 'kjs1673'), ('seohyun', '1673');
    """
    )


def print_all_users():
    res = corsur.execute("""SELECT * FROM users""")
    data = res.fetchall()

    print(data)


def i_change_password(username, password):
    corsur.execute(
        f"""
        UPDATE users SET password='{password}' WHERE username='{username}'
    """
    )


def s_change_password(username, password):
    corsur.execute(
        """
        UPDATE users SET password=? WHERE name=?;
    """,
        (password, username),
    )

# data = [
#     ("lanna", 567),
#     ("bora", 123),
#     ("max", 123),
#     ("jia", 890),
# ]

# corsur.executemany("""INSERT INTO users (name, password) VALUES (?, ?)""", data) # 오로지 튜블의 순서에 의해서 데이터가 삽입이 된다

data = [
    {"name": "lanna", "password": 567},
    {"name": "bora", "password": 123},
    {"name": "max", "password": 123},
    {"name": "jia", "password": 890},
]

corsur.executemany("""INSERT INTO users (name, password) VALUES (:name, :password)""", data) # 딕셔너리의 키값을 이용해서 데이터를 삽입한다


print_all_users()

conn.commit()
conn.close()
