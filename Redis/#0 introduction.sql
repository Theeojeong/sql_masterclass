Redis는 매우 빠르다

Redis = Remote Dictionary Service

in-memory 데이터베이스이기 때문이다

메모리에서 값을 읽는 것은 디스크에서 읽는 것보다 항상 빠르다

SQlite, MySQL, PostgreSQL, MongoDB 모두 디스크에 값을 읽고 저장한다

그래서 어떤 값을 검색할 때 하드 드라이브에 디스크로 가서 원하는 값을 찾아야한다

이런 과정들은 메모리에서 값을 읽어오고 저장하는 방식보다 항상 시간이 더 오래 걸린다

하지만 단점도 있다

하드 드라이브와 같은 저장 장치들은 훨씬 비용이 저렴하다

TB 용량의 디스크를 사용할 수도 있다

메모리는 사실 비용이 많이 든다

그래서 SQlite, MySQL, PostgreSQL, MongoDB와 같이 사용하는 경우가 대부분이다

만약 사용자가 무언가를 요청할 때, Redis에서 찾을 수 없다면

그 값을 SQlite, MySQL, PostgreSQL, MongoDB에서 찾고

그 값을 Redis에 저장한다


Redis는 현재 메모리 상태를 백업하는 데이터베이스로서 작동하는 것이다

