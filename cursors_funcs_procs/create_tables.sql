-- Create movies table
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT,
    genre VARCHAR(50)
);

-- Create actors table
CREATE TABLE actors (
    actor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year INT
);

-- Create junction table for many-to-many relationship
CREATE TABLE movie_actor (
    movie_id INT REFERENCES movies(movie_id),
    actor_id INT REFERENCES actors(actor_id),
    PRIMARY KEY (movie_id, actor_id)
);

-- Insert sample movies
INSERT INTO movies (title, release_year, genre) VALUES
('Inception', 2010, 'Sci-Fi'),
('The Dark Knight', 2008, 'Action'),
('Pulp Fiction', 1994, 'Crime'),
('Forrest Gump', 1994, 'Drama'),
('The Matrix', 1999, 'Sci-Fi');

-- Insert sample actors
INSERT INTO actors (name, birth_year) VALUES
('Leonardo DiCaprio', 1974),
('Christian Bale', 1974),
('John Travolta', 1954),
('Tom Hanks', 1956),
('Keanu Reeves', 1964);

-- Assign actors to movies (many-to-many)
INSERT INTO movie_actor (movie_id, actor_id) VALUES
(1, 1), -- Inception → DiCaprio
(2, 2), -- The Dark Knight → Bale
(3, 3), -- Pulp Fiction → Travolta
(4, 4), -- Forrest Gump → Hanks
(5, 5), -- The Matrix → Reeves
(1, 2); -- Inception → Bale (additional)
