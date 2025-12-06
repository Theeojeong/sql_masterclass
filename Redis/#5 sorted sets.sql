Z = sorted set

127.0.0.1:6379> ZADD scores 1 user:1 2 user:2 10 user:3 49 user:4
(integer) 4 
-- scores라는 키에 user:1, user:2, user:3, user:4를 추가하고 각각 1, 2, 10,, 49의 score를 부여한다

127.0.0.1:6379> ZRANGE scores 0 -1
1) "user:1"
2) "user:2"
3) "user:3"
4) "user:4"

127.0.0.1:6379> ZRANGE scores 0 -1 WITHSCORES -- 점수와 함께
1) "user:1"
2) "1"
3) "user:2"
4) "2"
5) "user:3"
6) "10"
7) "user:4"
8) "49"
-- 내림차순으로 알아서 정렬이 되어있다

127.0.0.1:6379> ZREVRANGE scores 0 -1
1) "user:4"
2) "user:3"
3) "user:2"
4) "user:1"
-- 역정렬

127.0.0.1:6379> ZRANK scores user:2
(integer) 1
-- user:2의 순위를 확인할 수 있다

127.0.0.1:6379> ZADD scores 20 user:2
(integer) 0
-- user:2의 점수를 20으로 변경하는 방법 1

127.0.0.1:6379> ZINCRBY scores 5 user:2
"25"
127.0.0.1:6379> ZINCRBY scores 5 user:2
"30"
-- user:2의 점수를 20으로 변경하는 방법 2

127.0.0.1:6379> ZSCORE scores user:3
"10"
-- user:3의 점수를 확인하는 방법

127.0.0.1:6379> ZRANGEBYSCORE scores 7 50
1) "user:3"
2) "user:2"
3) "user:4"
-- 7점 이상 50점 이하의 점수를 가진 유저를 찾는 방법

127.0.0.1:6379> ZRANGEBYSCORE scores 7 50 withscores
1) "user:3"
2) "10"
3) "user:2"
4) "30"
5) "user:4"
6) "49"

127.0.0.1:6379> ZCOUNT scores 7 50
(integer) 3
-- 7점 이상 50점 이하의 점수를 가진 유저의 수를 확인하는 방법

127.0.0.1:6379> ZREM scores user:2
(integer) 1
-- user:2를 삭제하는 방법

127.0.0.1:6379> ZRANGE scores 0 -1
1) "user:1"
2) "user:3"
3) "user:4"