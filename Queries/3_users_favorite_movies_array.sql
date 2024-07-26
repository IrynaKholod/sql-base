SELECT 
    u.id AS "ID",
    u.username AS "Username",
    ARRAY_AGG(fm.movieId) AS "Favorite movie IDs"
FROM 
    USERS u
LEFT JOIN 
    favorite_movies fm ON fm.userId = u.id
GROUP BY
    u.id, u.username;
