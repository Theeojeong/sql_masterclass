-- <세번째 isolation level>

-- phantom read

-- 동일한 row 집합을 두 번 조회했을 때, 처음과 다른 row 개수가 반환되는 경우다

-- 반면 Non-Repeatable Read는 동일한 row에 대해서 여러 번 읽을 때, 매번 다른 값을 얻는 것을 말한다

-- 그래서, Non-Repeatable Read는 주로 update 때문에 발생하고

-- phantom read는 insert나 delete를 실행해서 발생한다

-- 그러니까 Non-Repeatable Read는 변하는 값에 대한 것이고

-- phantom read는 row(행)의 달라지는 개수에 관한 것이다.