DROP TABLE movies; -- 테이블 삭제

CREATE TABLE movies( -- 테이블 생성
   movie_id INTEGER PRIMARY KEY AUTOINCREMENT, -- INTEGER=int, PRIMARY KEY=고유 식별자, AUTOINCREMENT=이걸 활성화 하지 않을 경우 sqlite는 
  -- 삭제된 movie_id를 새로운 데이터에 할당함, 활성화할 경우 삭제된 movie_id를 재사용하지 않음
   title TEXT UNIQUE NOT NULL, 
   released INTEGER NOT NULL,
   overview TEXT NOT NULL CHECK (LENGTH(overview) < 10), -- CHECH=조건부 함수를 걸어주는 명령어, LENGTH=글자수를 세어주는 sqlite 내장 함수 
   rating REAL NOT NULL CHECK (rating BETWEEN 0 and 10), -- REAL=FLOAT
   director TEXT,
   for_kids INTEGER NOT NULL DEFAULT 0 CHECK (for_kids BETWEEN 0 and 1) -- sqlite에서는 BOOLEAN을 INT로 표현한다. ex) 0, 1
   -- posert BLOB -> byte large object 즉 이진 데이터 덩어리란 뜻이고 이미지를 저장할 때 사용한다.
 ) STRICT; -- STRICT=각 칼럼에 부여된 조건들을 강제해주는 명령어

INSERT INTO movies VALUES (
  'kingkong',
  1999,
  'very good',
  9.9,
  'steven'
);

INSERT INTO movies 
  (title, released, overview, rating) -- 입력하고 싶은 칼럼만 선택할 수 있음
  VALUES 
  ('우리들만의 블루스', 2025, '재밋asdasfasdewfwfwefssdf음', 9.9), 
  ('인터스텔라', 2014, '심오함', 10);











