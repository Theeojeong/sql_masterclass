-- aggregate는 group by와 유사하다 
-- Stage는 데이터에 적용하고 싶은 변환과 집계 과정을 말한다


db.movies.aggregate([
    {$count: "total_movies"}    
])
-- 모든 document를 찾고
-- total_movies를 반환한다
-- count는 document의 수를 반환한다

db.movies.aggregate([
    { $group: { _id: null, avgRating: { $avg: "$rating" } } }
])
-- 모든 document를 찾고
-- null을 _id로 사용하여 모든 document를 group by 한다
-- avgRating은 rating의 평균을 반환한다

db.movies.aggregate([{ $unwind: "$genres"}])
-- 모든 document를 찾고
-- genres를 unwind 한다
-- unwind: document를 여러 document로 해체한다
-- postgresql의 unnest와 유사하다

db.movies.aggregate([
    { $unwind: "$genres" },
    { $group: { _id: "$genres", count: { $sum: 1 } } }
])
-- 모든 document를 찾고
-- genres를 unwind 한다
-- group by를 한다
-- count는 genres의 수를 반환한다   

db.movies.aggregate([
    { $unwind: "$genres" },
    { $group: 
        {
            _id: "$genres", 
            count: { $sum: 1 } -- stage 1
        }
    },
    { $sort: { count: -1 } } -- stage 2
])
-- 모든 document를 찾고
-- genres를 unwind 한다
-- group by를 한다
-- count는 genres의 수를 반환한다
-- count를 기준으로 내림차순으로 sort를 한다  

db.movies.aggregate([
    { $group: {
        _id: null,
        oldestMovie: { $min: "$year" },
        newestMovie: { $max: "$year" }
    }}
])
-- 모든 document를 찾고
-- group by를 한다
-- oldestMovie는 가장 오래된 영화를 반환한다
-- newestMovie는 가장 최근의 영화를 반환한다

db.movies.aggregate([
    {
        $group: {
            _id: "$year",
            avgDuration: { $avg: "$duration"}
        }
    },
    {
        $sort: { _id: -1}
    }
])
-- 모든 document를 찾고
-- 연도별로가 빠졌잖아 ai 멍청한 놈아 group by를 한다
-- avgDuration은 duration의 평균을 반환한다
-- _id를 기준으로 내림차순으로 sort를 한다

db.movies.aggregate([
    {
        $match: { director: {$exists: true}}
    },
    {
        $group: {
            _id: "$director",
            movieCount: { $sum: 1 }
        }
    },
    {
        $sort: { movieCount: -1 }
    }    
])
-- 모든 document를 찾고
-- director가 null이 아닌 document를 찾는다
-- director를 group by 한다
-- movieCount는 director의 수를 반환한다
-- movieCount를 기준으로 내림차순으로 sort를 한다


db.movies.aggregate([
    {
        $unwind: "$cast"
    },
    {
        $group: {
            _id: "$cast",
            movieCount: { $sum: 1 }
        }
    },
    {
        $sort: { movieCount: -1 }
    }    
])
-- 모든 document를 찾고
-- cast를 unwind 한다
-- cast를 group by 한다
-- movieCount는 cast의 수를 반환한다
-- movieCount를 기준으로 내림차순으로 sort를 한다

db.movies.aggregate([
    {
        $project: { title:1, director:1, cast:1}
    },
    {
        $limit: 10
    }
])
-- 모든 document를 찾고
-- title, director, cast를 반환한다
-- limit를 10으로 한다
