SELECT 
    "user".id AS "ID",
    "user".username AS "Username",
    ARRAY_AGG(favorite_movies.movieId) AS "Favorite movie IDs"
FROM 
    "user"
LEFT JOIN 
    favorite_movies ON favorite_movies.userId = "user".id
GROUP BY
    "user".id, "user".username;
