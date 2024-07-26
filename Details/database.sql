CREATE TABLE user_file (
    id SERIAL PRIMARY KEY,
    fileName VARCHAR(255) NOT NULL,
    mimeType VARCHAR(255) NOT NULL,
    key VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatarId INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (avatarId) REFERENCES user_file(id)
);

CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person_file (
    id SERIAL PRIMARY KEY,
    fileName VARCHAR(255) NOT NULL,
    mimeType VARCHAR(255) NOT NULL,
    key VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255),
    biography TEXT,
    dateOfBirth DATE,
    gender VARCHAR(50),
    countryId INT,
    primaryPhotoId INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (countryId) REFERENCES countries(id),
    FOREIGN KEY (primaryPhotoId) REFERENCES person_file(id)
);

CREATE TABLE movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    budget DECIMAL(10, 2),
    releaseDate DATE,
    duration INT,
    directorId INT,
    countryId INT,
    posterId INT,
    genres VARCHAR(255), 
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (directorId) REFERENCES person(id),
    FOREIGN KEY (countryId) REFERENCES countries(id),
    FOREIGN KEY (posterId) REFERENCES user_file(id)
);

CREATE TABLE character (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    role VARCHAR(255),
    movieId INT,
    personId INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movieId) REFERENCES movie(id),
    FOREIGN KEY (personId) REFERENCES person(id)
);

CREATE TABLE favorite_movies (
    userId INT,
    movieId INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (userId, movieId),
    FOREIGN KEY (userId) REFERENCES "user"(id),
    FOREIGN KEY (movieId) REFERENCES movie(id)
);
