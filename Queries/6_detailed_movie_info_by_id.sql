SELECT
    movie.id AS "ID",
    movie.title AS "Title",
    movie.releaseDate AS "Release Date",
    movie.duration AS "Duration",
    movie.description AS "Description",
    json_build_object(
        'fileName', user_file.fileName,
        'mimeType', user_file.mimeType,
        'url', user_file.url
    ) AS "Poster",
    json_build_object(
        'id', person.id,
        'firstName', person.firstName,
        'lastName', person.lastName,
        'photo', json_build_object(
            'fileName', person_file.fileName,
            'mimeType', person_file.mimeType,
            'url', person_file.url
        )
    ) AS "Director",
    (SELECT json_agg(
        json_build_object(
            'id', p.id,
            'firstName', p.firstName, 
            'lastName', p.lastName,
            'photo', json_build_object(
                'fileName', pf.fileName,
                'mimeType', pf.mimeType,
                'url', pf.url
            )
        )
    )
    FROM person p
    LEFT JOIN person_file pf ON pf.id = p.primaryPhotoId
    INNER JOIN character c ON p.id = c.personId
    WHERE c.movieId = movie.id) AS "Actors",
    movie.genres AS "Genres"
FROM
    movie
LEFT JOIN user_file ON user_file.id = movie.posterId
LEFT JOIN person ON person.id = movie.directorId
LEFT JOIN person_file ON person_file.id = person.primaryPhotoId
WHERE 
    movie.id = 1;
