SELECT
    p.id AS "Director ID",
    CONCAT(p.firstName, ' ', p.lastName) AS "Director name",
    AVG(m.budget) AS "Average budget"
FROM
    persons p
INNER JOIN
    movies m ON m.directorId = p.id
GROUP BY
    p.id, p.firstName, p.lastName;