CREATE TABLE user_files (
    id SERIAL PRIMARY KEY,
    fileName VARCHAR(255) NOT NULL,
    mimeType VARCHAR(255) NOT NULL,
    key VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatarId INT,
    FOREIGN KEY (avatarId) REFERENCES user_files(id)
);

CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE person_files (
    id SERIAL PRIMARY KEY,
    fileName VARCHAR(255) NOT NULL,
    mimeType VARCHAR(255) NOT NULL,
    key VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL
);

CREATE TABLE persons (
    id SERIAL PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255),
    biography TEXT,
    dateOfBirth DATE,
    gender VARCHAR(50),
    countryId INT,
    primaryPhotoId INT,
    FOREIGN KEY (countryId) REFERENCES countries(id),
    FOREIGN KEY (primaryPhotoId) REFERENCES person_files(id)
);

CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    budget DECIMAL(10, 2),
    releaseDate DATE,
    duration INT,
    directorId INT,
    countryId INT,
    posterId INT,
    FOREIGN KEY (directorId) REFERENCES persons(id),
    FOREIGN KEY (countryId) REFERENCES countries(id),
    FOREIGN KEY (posterId) REFERENCES user_files(id)
);

CREATE TABLE characters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    role VARCHAR(255),
    movieId INT,
    personId INT,
    FOREIGN KEY (movieId) REFERENCES movies(id),
    FOREIGN KEY (personId) REFERENCES persons(id)
);


CREATE TABLE favorite_movies (
    userId INT,
    movieId INT,
    PRIMARY KEY (userId, movieId),
    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (movieId) REFERENCES movies(id)
);