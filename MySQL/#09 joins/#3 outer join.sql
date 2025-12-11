-- outer join에는 right outer join과 left outer join이 있음
-- 그리고 inner처럼 outer는 생략 가능

SELECT
 	dogs.name AS dog_name,
 	owners.name AS owner_name,
 	breeds.name AS breed_name
FROM 
	dogs  
	JOIN owners USING (owner_id) 
	JOIN breeds USING (breed_id);
	
-- 애매하거나 의미가 불분명한 row를 확인해야 할 때 사용한다

OUTER JOIN은 "한쪽 또는 양쪽 다 포함" 겁니다!
직관적 이해: "빠짐없이" 또는 "누락 방지" 생각하면 돼요.

세 가지 종류
1. LEFT OUTER JOIN (LEFT JOIN)
	왼쪽 테이블은 다 살리기!
	학생 테이블 (왼쪽):        성적 테이블 (오른쪽):
	학번 | 이름               학번 | 점수
	1   | 김철수             1   | 95
	2   | 이영희             2   | 88
	3   | 박민수

LEFT JOIN 결과:
	학번 | 이름   | 점수
	1   | 김철수 | 95
	2   | 이영희 | 88
	3   | 박민수 | NULL  ← 성적 없어도 나타남!
학생은 다 보여주되, 성적이 없으면 NULL