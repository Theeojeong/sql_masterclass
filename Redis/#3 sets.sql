SET은 list와 비슷하지만 중복을 허용하지 않는다

다시 강조*
Redis는 메모리가 가진 데이터 구조를 다루는 것에 대한 것이다

노래에 투표했던 사람들을 갖고 있는 SET을 만들고 싶다

127.0.0.1:6379> SADD votes:song:1 user:1
(integer) 1
127.0.0.1:6379> SADD votes:song:1 user:1
(integer) 0
-- 이렇게 user:1이 votes:song:1에 투표를 하면 다시 투표하는 것을 허용하지 않는다
-- 즉 중복을 허용하지 않음

127.0.0.1:6379> SADD votes:song:1 user:2
(integer) 1
127.0.0.1:6379> SADD votes:song:1 user:2
(integer) 0
-- 마찬가지

127.0.0.1:6379> SMEMBERS votes:song:1 -- votes:song:1에 투표한 사람을 보두 보여준다
1) "user:1"
2) "user:2"

127.0.0.1:6379> SISMEMBER votes:song:1 user:1 -- votes:song:1에 user:1이 투표했는지 확인할 수 있다
(integer) 1

127.0.0.1:6379> SCARD votes:song:1 -- votes:song:1에 투표한 사람의 수를 확인할 수 있다  
(integer) 2

127.0.0.1:6379> SADD votes:song:2 user:3 user:4 user:5 -- votes:song:2에 user:3, user:4, user:5를 추가한다
(integer) 3

127.0.0.1:6379> SINTER votes:song:1 votes:song:2 -- votes:song:1과 votes:song:2에 모두 투표한 사람 즉, 교집합을 구한다
1) "user:1"

127.0.0.1:6379> SDIFF votes:song:1 votes:song:2 -- song:1에 투표했지만 song:2에는 투표 안 한 유저 찾기 즉, 차집합을 구한다
1) "user:2"                                     -- SDIFF는 첫 번째 집합에서 두 번째 집합을 빼는 차집합 연산.


127.0.0.1:6379> SUNION votes:song:1 votes:song:2 -- song:1과 song:2에 모두 투표한 유저 찾기 즉, 합집합을 구한다
1) "1"
2) "user:4"
3) "user:2"
4) "user"
5) "user:3"
6) "user:1"
7) "user:5"

127.0.0.1:6379> SREM votes:song:1 user:1 -- votes:song:1에서 user:1을 제거한다
(integer) 1