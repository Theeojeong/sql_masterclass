-- 몽고디비에 바로 접근해서 사용하는 경우는 거의 없다
-- 대부분 드라이버를 사용하여 접근한다

SQL에는 데이터베이스가 있고 테이블이 있다

MongoDB에는 데이터베이스가 있고 collection이 있다

SQL에서 테이블은 행을 가지고 있고 모든 행은 레코드다

MongoDB에는 컬렉션은 Document를 가지고 있다

정리하자면 SQL의 데이터베이스는 MongoDB의 데이터베이스와 같다
SQL의 테이블은 MongoDB의 컬렉션과 같다
SQL의 행은 MongoDB의 Document와 같다


use movies -- 데이터베이스 생성

db.createCollection("movies") -- 컬렉션 생성

db.movies.insertOne({
title:"The Godfather",
year: 1999,
director: {
  name: "F.F.C",
  alive: true
},
 genres: ['Crime', 'Drama', 'Pizza'] 
}) -- document 생성


db.movies.insertMany([{title:"interstella"}, {title:"minions"}]) -- 여러 document 생성