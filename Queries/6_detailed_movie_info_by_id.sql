SELECT
    movies.id AS "ID",
    movies.title AS "Title",
    movies.releaseDate AS "Release Date",
    movies.duration AS "Duration",
    movies.description AS "Description",
    json_build_object(
        'fileName', user_files.fileName,
        'mimeType', user_files.mimeType,
        'url', user_files.url
    ) AS "Poster",
    json_build_object(
        'id', persons.id,
        'firstName', persons.firstName,
        'lastName', persons.lastName,
        'photo', json_build_object(
            'fileName', person_files.fileName,
            'mimeType', person_files.mimeType,
            'url', person_files.url
        )
    ) AS "Director",
    (SELECT json_agg(
        json_build_object(
            'id', actors.id,
            'firstName', actors.firstName, 
            'lastName', actors.lastName,
            'photo', json_build_object(
                'fileName', actor_files.fileName,
                'mimeType', actor_files.mimeType,
                'url', actor_files.url
            )
        )
    )
    FROM persons actors
    LEFT JOIN person_files actor_files ON actor_files.id = actors.primaryPhotoId
    INNER JOIN characters ON actors.id = characters.personId
    WHERE characters.movieId = movies.id) AS "Actors",
    movies.genres AS "Genres"
FROM
    movies
LEFT JOIN user_files ON user_files.id = movies.posterId
LEFT JOIN persons ON persons.id = movies.directorId
LEFT JOIN person_files ON person_files.id = persons.primaryPhotoId
WHERE 
    movies.id = 1;
