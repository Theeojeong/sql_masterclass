Redis안에 데이터를 넣는 방법

127.0.0.1:6379> SET hello world
OK
-- hello라는 키에 world라는 값을 저장한다

127.0.0.1:6379> GET hello
"world"
-- hello 키의 값을 가져온다

SET은 항상 값을 덮어쓰기한다

127.0.0.1:6379> SET hello bye
OK
127.0.0.1:6379> GET hello
"bye"

대다수의 상황에서는 이런 식으로 사용한다

127.0.0.1:6379> set users:1 jaehyeon
OK
127.0.0.1:6379> get users:1
"jaehyeon"

users:1이라는 키에 jaehyeon이라는 값을 저장한다
users:1 은 관례이다

데이터를 삭제하는 방법

127.0.0.1:6379> DEL users:1 hello
(integer) 2
-- users:1와 hello 키를 삭제한다

모든 데이터를 삭제하는 방법

127.0.0.1:6379> FLUSHALL
OK


REDIS는 키 만료 시점을 정할 수 있다

127.0.0.1:6379> SET users:1 jaehyeon nx ex 10
OK
-- users:1 키가 jaehyeon으로 설정되고 10초 후에 자동으로 삭제된다
-- NX는 users:1 값이 존재하지 않을 때 jaehyeon 라는 값을 저장하라는 뜻
-- XX는 users:1 값이 존재할 때 jaehyeon 라는 값을 저장하라는 뜻

10초 후 
127.0.0.1:6379> get users:1
(nil)

127.0.0.1:6379> SET users:1 jaehyeon XX
(nil)
-- XX는 users:1 값이 존재할 때 jaehyeon 라는 값을 저장하라는 뜻

127.0.0.1:6379> MSET users:1 jaehyeon users:2 seohyun users:3 yeji
OK
127.0.0.1:6379> MGET users:1 users:2 users:3
1) "jaehyeon"
2) "seohyun"
3) "yeji"


127.0.0.1:6379> SET visitors 0                                                                                                   
OK
127.0.0.1:6379> INCR visitors
(integer) 1
127.0.0.1:6379> INCR visitors
(integer) 2
127.0.0.1:6379> INCR visitors
(integer) 3
127.0.0.1:6379> DECR visitors
(integer) 2
127.0.0.1:6379> DECR visitors
(integer) 1
127.0.0.1:6379> DECR visitors
(integer) 0
127.0.0.1:6379> INCRBY visitors 10
(integer) 10
127.0.0.1:6379> DECRBY visitors 9
(integer) 1