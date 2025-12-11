from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")

databases = client.get_database("movies")
movies = databases.get_collection("movies")

query = {"director": "Christopher Nolan"}

x = movies.find(query)

for movie in x:
    print(movie)

