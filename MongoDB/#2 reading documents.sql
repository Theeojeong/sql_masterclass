db.movies.find() -- 모든 document를 찾는다

db.movies.find({director: "Christopher Nolan"}) 
-- director가 Christopher Nolan인 document를 찾는다 

db.movies.find({rating:{$gte: 8}}) -- $gte: greater than or equal to    
-- rating이 8이상인 document를 찾는다   

db.movies.find({year:{$gt: 2000, $lt:2010}}) -- AND
-- year가 2000보다 크고 2010보다 작은 document를 찾는다 

db.movies.find({$or:[{rating: {$gt: 9}}, {year: {$gte: 2020}}]}) -- OR  
-- rating이 9이상이거나 year가 2020이상인 document를 찾는다 

db.movies.find({ genres: { $in: ["Drama", "Crime"]}}) -- IN 
-- genres가 Drama이거나 Crime인 document를 찾는다   

db.movies.find({ genres: { $all: ["Drama", "Crime"]}}) -- ALL
-- genres가 Drama이면서 Crime인 document를 찾는다   

db.movies.find({ title: { $regex: /the/i }}) -- REGEX
-- title이 the로 시작하는 document를 찾는다 

 db.movies.find({ genres: { $size: 3}}) -- SIZE
-- genres가 3인 document를 찾는다   

db.movies.find({ director: { $exists: false}}) -- EXISTS
-- director가 없는 document를 찾는다    

db.movies.find({ "cast.0": "Keanu Reeves"}) -- CAST
-- cast의 첫번째가 Keanu Reeves인 document를 찾는다 

db.movies.find().skip(10) -- SKIP
-- 10개를 건너뛰고 document를 찾는다 

db.movies.find().limit(10) -- LIMIT
-- 10개만 document를 찾는다     

db.movies.find().sort({ rating: -1}).limit(10).skip(10) -- SORT
-- rating이 높은 document를 10개만 찾는다   

db.movies.find().sort({ rating: -1, title: 1}).limit(10).skip(10) -- SORT
-- rating이 높은 document를 10개만 찾고 title로 정렬한다    