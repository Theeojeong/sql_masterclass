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


# 변수들을 안전하게 SQL 쿼리에 INSERT하는 방법에 대해서 배운다
# 어떻게 하면 해킹당하지 않을 수 있는지
# 그리고 어떤 식으로 해킹 당할 수 있는지 본다

# 1. 안전하지 않은 방법

def i_change_password(username, password):
    corsur.execute(
        f"""
        UPDATE users SET password='{password}' WHERE username='{username}'
    """
    )

i_change_password("jaehyeon", "hacked' --") # 이렇게 password 뒤가 모두 주석 처리가 되면서 모든 users의 password가 hacked로 바뀌었다


# 2. 안전한 방법
def s_change_password(username, password):
    corsur.execute(
        """
        UPDATE users SET password=? WHERE name=?;
    """, (password, username)
    )

s_change_password('jaehyeon', '123')

print_all_users()

conn.commit()
conn.close()
