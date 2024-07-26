SELECT 
    m.id AS "ID",
    m.title AS "Title",
    COUNT(c.personId) AS "Actors count"
FROM 
    movie m
LEFT JOIN
    character c ON c.movieId = m.id
WHERE
    m.releaseDate > CURRENT_DATE - INTERVAL '5 years'
GROUP BY
    m.id, m.title;
