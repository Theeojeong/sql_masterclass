import sqlite3

conn = sqlite3.connect("C:/agent/sql_masterclass/data/movies.db")

cursor = conn.cursor()

res = cursor.execute("""SELECT * FROM movies""") # 실행시간 142ms

# all = res.fetchall() # 실행시간 1080ms


first_3 = res.fetchmany(3)
next_6 = res.fetchmany(3)

# cursor 객체는 데이터베이스 작업을 관리하는 포인터 혹은 책갈피와 같다
# MMMMMMMMMMMMMMMMMMMMMMMMMMM
# 위 코드가 실행되는 과정은
# first_3 = res.fetchmany(3) 이 코드가 실행되면 가장 왼쪽에 있던 cursor 포인터가 오른쪽으로 3칸을 이동하고 3개를 가져온다
# MMM {cursor 포인터 위치} MMMMMMMMMMMMMMMMMMMMMMMM
# 다음 next_6 = res.fetchmany(3) 코드가 실행되면 다시 오른쪽으로 3칸을 이동하고 3개를 가져온다
# MMM MMM {cursor 포인터 위치} MMMMMMMMMMMMMMMMMMMMM
# 만약 여기서 res.fetchall()을 실행하면 처음부터 끝까지 가져오는 것이 아니라 현재 포인터의 위치에서 오른쪽에 있는 모든 데이터를 가져온다

# print(
#     res.fetchone(),
#     res.fetchone(),
#     res.fetchone(),
#     res.fetchone(),
#     res.fetchone(),
#     res.fetchone(),
# )
# 위 코드는 하나씩 가져온다

for movies in res:
    print(movies)

conn.commit()
conn.close()
