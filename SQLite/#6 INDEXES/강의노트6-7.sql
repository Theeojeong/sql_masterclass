DB가 B+ Tree 구조 INDEX에서 leaf node를 찾았지만

leaf node가 쿼리에 필요한 데이터를 담고 있지 않다는 것을 알고 있다

예를 들어 Francis Ford Coppola가 만든 영화 제목을 요청하면

제목은 leaf node에 저장되어 있지 않기 때문에

DB는 INDEX(B+ Tree)에서 실제 메인 DB로 점프해야한다


사실 SQLite나 MySQL의 경우 data의 모든 행도 실제로 B+ Tree를 사용하여 구조화되어 있다

INDEX의 leaf node에는 movie_id와 director밖에 없지만 SQLite나 MySQL도 B+ Tree 구조이기 때문에

movie_id를 이용해서 director를 찾아 가는 과정과 동일하게 크기 비교를 통해 절반 옵션을 제거해 나가면서

모든 정보가 들어있는 leaf node에 도달하게 된다

그래서 SQLite나 MySQL에서 primary key를 사용해 영화를 빨리 찾을 수 있는 것이다

PostgreSQL 또한 primary key를 사용해 데이터를 빠르게 찾을 수 있다


Unique 칼럼을 만들면 자동으로 INDEX가 생성이 된다