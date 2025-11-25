-- 여러 table에서 동시에 data를 가져오는 유일한 방법은 join을 사용하는 것이다


-- cross join(별로 유용 x)
SELECT * FROM dogs CROSS JOIN owners;

-- cross join이 첫번째 table의 모든 row와 두번쨰 table의 모든 row를 각각 연결시킨다


JOIN = "연결하다", "붙이다"

두 개의 테이블을 옆으로 붙여서 하나의 넓은 표를 만드는 것이라고 생각하면 됩니다.

CROSS JOIN은 "모든 조합"을 만드는 겁니다!

직관적 이해: "곱하기" 또는 "조합 만들기"라고 생각하면 돼요.

일반 JOIN = 조건에 맞는 것만 연결
CROSS JOIN = 조건 없이 모든 것을 다 연결 (데카르트 곱)

실무에서는 CROSS JOIN을 조심해서 써야 해요. 테이블이 크면 결과가 엄청나게 많아지거든요! (1000개 × 1000개 = 100만개!)