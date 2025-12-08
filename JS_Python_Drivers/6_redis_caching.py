import redis
import sqlite3
import json

r = redis.Redis(
    host="localhost",
    port=6379,
    decode_responses=True # 설정하지 않으면 기본적으로 byte타입으로 받게 된다, True로 설정해서 문자열로 디코딩을 하도록 하자
)

# r.hset("users:4", mapping={"name":"izna", "age": 1})

# print(r.hgetall("users:4"))

conn = sqlite3.connect("C:/agent/sql_masterclass/data/movies.db")
cursor = conn.cursor()

def make_expansive_query():
    redis_key="movies:director"
    x = r.get(redis_key)
    if x:
        print("cache hit")
        return json.loads(x)
    else:
        print("cache miss")
        res = cursor.execute("""SELECT director, count(*) FROM movies GROUP BY director""") # res는 cursor 객체
        all_data = res.fetchall() # all_data -> [(), () , ().....]
        r.set(redis_key, json.dumps(all_data), ex=30)
    return all_data

v = make_expansive_query()

conn.commit()
conn.close()


# measure-command
