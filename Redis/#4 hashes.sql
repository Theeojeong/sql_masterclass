hash란 key와 value쌍의 모음이라 할 수 있다

파이썬의 딕셔너리, 몽고디비의 document와 비슷하다

127.0.0.1:6379> HSET player:1 name jaehyeon xp 0 health 100
(integer) 3
-- 이렇게 키-밸류 3쌍을 저장한다

127.0.0.1:6379> HGET player:1 name
"jaehyeon"
-- 이렇게 키로 밸류 값을 가져온다

127.0.0.1:6379> HGETALL player:1
1) "name"
2) "jaehyeon"
3) "xp"
4) "0"
5) "health"
6) "100"
-- 모두 가져오기

127.0.0.1:6379> HINCRBY player:1 xp 30
(integer) 30
-- xp를 30 증가시킨다

127.0.0.1:6379> HGETALL player:1
1) "name"
2) "jaehyeon"
3) "xp"
4) "30"
5) "health"
6) "100"

127.0.0.1:6379> HINCRBY player:1 health -30
(integer) 70
-- health를 30 감소시킨다

127.0.0.1:6379> HGETALL player:1
1) "name"
2) "jaehyeon"
3) "xp"
4) "30"
5) "health"
6) "70"


127.0.0.1:6379> HMGET player:1 xp health
1) "30"
2) "70"
-- 특정 키의 밸류만 가져오기


127.0.0.1:6379> HSET player:1 name seohyun
(integer) 0
-- 이름 변경하기