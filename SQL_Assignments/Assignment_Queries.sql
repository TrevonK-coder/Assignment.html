/* 
   =============================================================
   ASSIGNMENT CONSOLIDATED QUERIES
   Trevon K. - SQL Assignments
   =============================================================
   This script contains the database structure, data insertion, 
   and specific assignment queries for:
   1. The Custom Movie Database (db_movies)
   2. AdventureWorks Stored Procedure Exercise
   3. Combined Join Queries
   ============================================================= 
*/

-- =============================================================
-- PART 1: CUSTOM MOVIE DATABASE (Zoo Assignment)
-- =============================================================

-- 1. Create the Database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'db_movies')
BEGIN
    CREATE DATABASE db_movies;
END;
GO

USE db_movies;
GO

-- 2. Create Directors Table (Parent Table)
IF OBJECT_ID('dbo.tbl_directors', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_directors;

CREATE TABLE tbl_directors (
    director_id INT PRIMARY KEY IDENTITY (1,1),
    director_name VARCHAR(50) NOT NULL,
    director_specialty VARCHAR(50)
);

-- 3. Create Actors Table (Child Table with Foreign Key)
IF OBJECT_ID('dbo.tbl_actors', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_actors;

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
INSERT INTO tbl_actors (actor_name, actor_movie, actor_director_id)
VALUES 
('Cillian Murphy', 'Oppenheimer', 1),
('Robert Downey Jr.', 'Oppenheimer', 1),
('Margot Robbie', 'Barbie', 2),
('Samuel L. Jackson', 'Pulp Fiction', 3),
('Leonardo DiCaprio', 'The Departed', 5);

-- 6. Query data from both tables (Inner Join)
SELECT 
    tbl_directors.director_name AS 'Director', 
    tbl_actors.actor_name AS 'Actor', 
    tbl_actors.actor_movie AS 'Shared Movie'
FROM tbl_directors
INNER JOIN tbl_actors ON tbl_directors.director_id = tbl_actors.actor_director_id
WHERE tbl_actors.actor_movie = 'Oppenheimer';

GO

-- =============================================================
-- PART 2: ADVENTUREWORKS STORED PROCEDURE
-- =============================================================

-- 1. Use the AdventureWorks database
-- Note: This requires AdventureWorks2017 to be restored first.
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'AdventureWorks2017')
BEGIN
    USE AdventureWorks2017;
    EXEC('
    IF OBJECT_ID(''dbo.uspGetPersonContacts'', ''P'') IS NOT NULL
        DROP PROCEDURE dbo.uspGetPersonContacts;
    ');
    EXEC('
    CREATE PROCEDURE dbo.uspGetPersonContacts
    AS
    BEGIN
        SELECT FirstName, LastName, MiddleName
        FROM Person.Person;
    END;
    ');
    
    -- Execute the Stored Procedure
    EXEC dbo.uspGetPersonContacts;
END;
GO

-- =============================================================
-- PART 3: ADDITIONAL JOIN EXERCISES (Left Join)
-- =============================================================

-- Example of a Left Join between Customers and Orders
/*
SELECT 
    Customers.CustomerName, 
    Orders.OrderID, 
    Orders.OrderDate
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;
*/

GO
