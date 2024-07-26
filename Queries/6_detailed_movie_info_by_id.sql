SELECT
    m.id AS "ID",
    m.title AS "Title",
    m.releaseDate AS "Release Date",
    m.duration AS "Duration",
    m.description AS "Description",
    json_build_object(
        'fileName', uf.fileName,
        'mimeType', uf.mimeType,
        'url', uf.url
    ) AS "Poster",
    json_build_object(
        'id', p.id,
        'firstName', p.firstName,
        'lastName', p.lastName,
        'photo', json_build_object(
            'fileName', pf.fileName,
            'mimeType', pf.mimeType,
            'url', pf.url
        )
    ) AS "Director",
    (SELECT json_agg(
        json_build_object(
            'id', a.id,
            'firstName', a.firstName, 
            'lastName', a.lastName,
            'photo', json_build_object(
                'fileName', af.fileName,
                'mimeType', af.mimeType,
                'url', af.url
            )
        )
    )
    FROM PERSONS a
    LEFT JOIN person_files af ON af.id = a.primaryPhotoId
    INNER JOIN characters c ON a.id = c.personId
    WHERE c.movieId = m.id) AS "Actors",
    m.genres AS "Genres" -- Corrected column name
FROM
    movies m
LEFT JOIN user_files uf ON uf.id = m.posterId
LEFT JOIN persons p ON p.id = m.directorId
LEFT JOIN person_files pf ON pf.id = p.primaryPhotoId
WHERE 
    m.id = 1;
