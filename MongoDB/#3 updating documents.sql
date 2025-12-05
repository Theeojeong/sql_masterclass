db.movies.updateOne(
    {
        _id: ObjectId("67a1c2c2c2c2c2c2c2c2c2c2")   
    },
    {
        $set: {
            'director.name': "Francis Ford Coppola"
        }   
    }
)
-- _id가 ObjectId("67a1c2c2c2c2c2c2c2c2c2c2")인 document를 찾고     
-- director.name을 Francis Ford Coppola로 업데이트한다  

db.movies.updateOne(
    {
        _id: ObjectId("67a1c2c2c2c2c2c2c2c2c2c2")   
    },
    {
        $set: {
            'director.name': "Francis Ford Coppola"
        },
        $currentDate: {
            updated_at: true
        }      
    }
)
-- _id가 ObjectId("67a1c2c2c2c2c2c2c2c2c2c2")인 document를 찾고     
-- director.name을 Francis Ford Coppola로 업데이트한다  
-- updated_at을 현재 시간으로 업데이트한다

db.movies.findOneAndUpdate(
    {
        _id: ObjectId("67a1c2c2c2c2c2c2c2c2c2c2")   
    },
    {
        $set: {
            'director.name': "Francis Ford Coppola"
        },
        $currentDate: {
            updated_at: true
        }, { returnNewDocument: true, upsert: true}      
    }
)
-- _id가 ObjectId("67a1c2c2c2c2c2c2c2c2c2c2")인 document를 찾고     
-- director.name을 Francis Ford Coppola로 업데이트한다  
-- updated_at을 현재 시간으로 업데이트한다
-- returnNewDocument를 true로 설정하여 업데이트된 document를 반환한다
-- upsert를 true로 설정하여 document가 없으면 생성한다
-- updateOne과 findOneAndUpdate의 차이점은 updateOne은 document를 찾고 업데이트한다
-- findOneAndUpdate는 document를 찾고 업데이트한 후 반환한다   

db.movies.updateMany(
    { director: "Christoper Nolan"},
    {
        $inc: {rating: 0.2}
    }
)
-- director가 Christoper Nolan인 document를 찾고
-- rating을 0.2만큼 증가시킨다  

db.movies.updateMany(
    { title: "Inception"},
    {
        $push: { genres: "Mind-Control"}
    }
)
-- title이 Inception인 document를 찾고
-- genres에 Mind-Control을 추가한다

db.movies.updateMany(
    { title: "Inception"},
    {
        $pull: { genres: "Mind-Control"}
    }
)
-- title이 Inception인 document를 찾고
-- genres에서 Mind-Control을 제거한다   


db.movies.updateMany(
    { title: "The Dark Knight"},
    {
        $addToSet: { cast: "Michael Caine"}    
    }
)
-- title이 The Dark Knight인 document를 찾고
-- cast에 Michael Caine을 추가한다
-- addToSet은 중복을 허용하지 않는다    

db.movies.updateMany(
    {},
    {
        $rename: { runtime: "duration"}
    }
)
-- 모든 document를 찾고(첫번째 매개변수를 비워두면 모든 document를 찾는다)
-- runtime을 duration으로 변경한다

db.movies.updateOne(
    { title: "Inception"},
    { $set: {
        boxOffice:{
            domestic: 292576195,
            international: 535663842,
            worldwideTotal: 828239998
        }
    }}
)
-- title이 Inception인 document를 찾고
-- boxOffice를 추가한다

db.movies.updateOne(
    { title: "Inception"},
    { $inc: {"boxOffice.domestic": 200}}
)
-- title이 Inception인 document를 찾고
-- boxOffice.domestic을 200만큼 증가시킨다

db.movies.updateMany(
    {},
    { $unset: { plot: ""}}
)
-- 모든 document를 찾고
-- plot을 제거한다  

db.movies.updateMany(
    { $expr: { $lt: [{ $size: "$genres"}, 3]}},
    { $unset: { plot: ""}}
)
-- genres의 크기가 3보다 작은 document를 찾고
-- plot을 제거한다

db.movies.updateMany(
    { $expr: { $lt: [{ $size: "$genres"}, 3]}},
    { $addToSet: { genres: { $each: ["other", "Happy"]}}}
)
-- genres의 크기가 3보다 작은 document를 찾고
-- genres에 other와 Happy를 추가한다    
-- { $addToSet: { genres: ["other", "Happy"]}} 이 쿼리는 배열 자체를 추가
-- $each를 사용하면 배열의 각 요소를 개별적으로 추가한다
-- $each를 사용하면 중복을 허용하지 않는다

-- <<Delete>>
db.movies.deleteOne()

-- CRUD는 모두 배웠다!