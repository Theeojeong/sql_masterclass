127.0.0.1:6379> set hi hello
OK

127.0.0.1:6379> get hi
"hello"

127.0.0.1:6379> expire hi 10
(integer) 1

127.0.0.1:6379> get hi
"hello"

127.0.0.1:6379> get hi
(nil)

-- expire 문법
expire key seconds

expire hi 10은 hi의 value값을 10초 동안만 보관하겠다는 뜻 
