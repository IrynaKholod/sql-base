SELECT
    m.id AS "ID",
    m.title AS "Title",
    m.releaseDate AS "Release Date",
    m.duration AS "Duration",
    m.description AS "Description",
    json_build_object(
        'fileName', f.fileName,
        'mimeType', f.mimeType,
        'url', f.url
    ) AS "Poster",
    json_build_object(
        'id', p.id,
        'firstName', p.firstName,
        'lastName', p.lastName
    ) AS "Director"
FROM
    movies m
LEFT JOIN
    user_files f ON f.id = m.posterId
LEFT JOIN 
    persons p ON p.id = m.directorId
WHERE
    m.countryId = 1
    AND m.releaseDate >= '2022-01-01'
    AND m.duration > 135
    AND m.genres IN ('Action', 'Drama');
