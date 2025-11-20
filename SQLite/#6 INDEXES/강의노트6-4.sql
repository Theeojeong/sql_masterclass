SELECT
	*
FROM
	movies
WHERE
	director = 'Guy Ritchie';

CREATE INDEX idx_director ON movies (director);

DROP INDEX idx_director;



인덱싱을 사용하면 왜 속도가 빨라질까?

인덱스를 생성할 때 만들어지는 데이터 구조가 바로 B+ Tree이다.

처음 root node에서 두 갈래의 internal node 뻗어나간다

각 internal node는 또 다시 두 갈래의 internal node로 뻗어나간다.

이 각 internal node는 두 갈래의 leaf node를 생성하고 가지 뻗기가 끝난다.

CREATE INDEX idx_director ON movies (director); 만약 이 인덱스를 생성한다면

각 감독의 이름이 leaf node가 된다. 

참고로 leaf node는 감독 이름의 알파벳 순서로 정렬되어있다.

예를 들어 당신은 francis ford coppola라는 값을 가진 leaf node를 찾고 싶다

어떻게 이 b+ tree는 원하는 leaf node를 검색할 수 있을까

너가 찾고 있는 값을 internal node와 비교한다

너가 찾고 있는 값이 비교하는 노드보다 크거나 작은지에 따라 왼쪽이나 오른쪽으로 간다

첫 root node에서 francis ford coppola의 앞글자 f와 크기를 비교하여 옵션의 절반을 소거한다.

소거법과 같다고 보면 될듯

root node에서 f가 root node의 앞글자 보다 크면 오른쪽으로 이동 -> internal node가 내가 찾고자 하는 값과 일치하면 오른쪽으로 이동 -> 다시 마주친 internal node의 앞글자보다 작으면 왼쪽으로 이동

이렇게 3단계에 걸쳐서 찾게 된다