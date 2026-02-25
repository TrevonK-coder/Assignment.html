/* Zoo Database Assignment 7 
   Task: Create a custom database with two tables, primary/foreign keys, 
   at least 5 rows per table, and a join query.
*/

-- 1. Create the Database
CREATE DATABASE db_movies;
GO
USE db_movies;
GO

-- 2. Create Directors Table (Parent Table)
CREATE TABLE tbl_directors (
    director_id INT PRIMARY KEY IDENTITY (1,1),
    director_name VARCHAR(50) NOT NULL,
    director_specialty VARCHAR(50)
);

-- 3. Create Actors Table (Child Table with Foreign Key)
-- 
CREATE TABLE tbl_actors (
    actor_id INT PRIMARY KEY IDENTITY (100,1),
    actor_name VARCHAR(50) NOT NULL,
    actor_movie VARCHAR(100) NOT NULL,
    actor_director_id INT CONSTRAINT fk_director_id FOREIGN KEY REFERENCES tbl_directors(director_id)
);

-- 4. Add Values to Directors (5 rows)
INSERT INTO tbl_directors (director_name, director_specialty)
VALUES 
('Christopher Nolan', 'Sci-Fi'),
('Greta Gerwig', 'Drama'),
('Quentin Tarantino', 'Action'),
('Steven Spielberg', 'Adventure'),
('Martin Scorsese', 'Crime');

-- 5. Add Values to Actors (5 rows)
-- Note: 'Oppenheimer' is used to match an actor to a director
INSERT INTO tbl_actors (actor_name, actor_movie, actor_director_id)
VALUES 
('Cillian Murphy', 'Oppenheimer', 1),
('Robert Downey Jr.', 'Oppenheimer', 1),
('Margot Robbie', 'Barbie', 2),
('Samuel L. Jackson', 'Pulp Fiction', 3),
('Leonardo DiCaprio', 'The Departed', 5);

-- 6. Query data from both tables sharing an attribute (Oppenheimer)
-- 
SELECT 
    tbl_directors.director_name AS 'Director', 
    tbl_actors.actor_name AS 'Actor', 
    tbl_actors.actor_movie AS 'Shared Movie'
FROM tbl_directors
INNER JOIN tbl_actors ON tbl_directors.director_id = tbl_actors.actor_director_id
WHERE tbl_actors.actor_movie = 'Oppenheimer';