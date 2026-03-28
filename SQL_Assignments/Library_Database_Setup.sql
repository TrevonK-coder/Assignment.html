/* 
   =============================================================
   LIBRARY MANAGEMENT SYSTEM DATABASE SETUP
   Trevon K. - SQL Assignment
   =============================================================
   This script creates the db_Library database, its tables, 
   primary/foreign keys, and populates them with sample data.
   ============================================================= 
*/

-- 1. Create the Database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'db_Library')
BEGIN
    CREATE DATABASE db_Library;
END;
GO

USE db_Library;
GO

-- 2. Drop existing tables to ensure a clean setup (Order matters due to FKs)
IF OBJECT_ID('dbo.BOOK_LOANS', 'U') IS NOT NULL DROP TABLE dbo.BOOK_LOANS;
IF OBJECT_ID('dbo.BOOK_COPIES', 'U') IS NOT NULL DROP TABLE dbo.BOOK_COPIES;
IF OBJECT_ID('dbo.BOOK_AUTHORS', 'U') IS NOT NULL DROP TABLE dbo.BOOK_AUTHORS;
IF OBJECT_ID('dbo.BOOKS', 'U') IS NOT NULL DROP TABLE dbo.BOOKS;
IF OBJECT_ID('dbo.BORROWER', 'U') IS NOT NULL DROP TABLE dbo.BORROWER;
IF OBJECT_ID('dbo.LIBRARY_BRANCH', 'U') IS NOT NULL DROP TABLE dbo.LIBRARY_BRANCH;
IF OBJECT_ID('dbo.PUBLISHER', 'U') IS NOT NULL DROP TABLE dbo.PUBLISHER;
GO

-- 3. Create Tables

-- PUBLISHER Table
CREATE TABLE PUBLISHER (
    PublisherName VARCHAR(100) PRIMARY KEY,
    Address VARCHAR(200) NOT NULL,
    Phone VARCHAR(20) NOT NULL
);

-- LIBRARY_BRANCH Table
CREATE TABLE LIBRARY_BRANCH (
    BranchID INT PRIMARY KEY IDENTITY(1,1),
    BranchName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL
);

-- BORROWER Table
CREATE TABLE BORROWER (
    CardNo INT PRIMARY KEY IDENTITY(100,1),
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    Phone VARCHAR(20) NOT NULL
);

-- BOOKS Table
CREATE TABLE BOOKS (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(100) NOT NULL,
    PublisherName VARCHAR(100) NOT NULL CONSTRAINT fk_publisher_name FOREIGN KEY REFERENCES PUBLISHER(PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
);

-- BOOK_AUTHORS Table
CREATE TABLE BOOK_AUTHORS (
    BookID INT NOT NULL CONSTRAINT fk_book_authors_id FOREIGN KEY REFERENCES BOOKS(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
    AuthorName VARCHAR(100) NOT NULL,
    PRIMARY KEY (BookID, AuthorName)
);

-- BOOK_COPIES Table
CREATE TABLE BOOK_COPIES (
    BookID INT NOT NULL CONSTRAINT fk_book_copies_id FOREIGN KEY REFERENCES BOOKS(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
    BranchID INT NOT NULL CONSTRAINT fk_branch_id_copies FOREIGN KEY REFERENCES LIBRARY_BRANCH(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
    Number_Of_Copies INT NOT NULL,
    PRIMARY KEY (BookID, BranchID)
);

-- BOOK_LOANS Table
CREATE TABLE BOOK_LOANS (
    BookID INT NOT NULL CONSTRAINT fk_book_loans_id FOREIGN KEY REFERENCES BOOKS(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
    BranchID INT NOT NULL CONSTRAINT fk_branch_id_loans FOREIGN KEY REFERENCES LIBRARY_BRANCH(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
    CardNo INT NOT NULL CONSTRAINT fk_card_no FOREIGN KEY REFERENCES BORROWER(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
    DateOut DATE NOT NULL,
    DueDate DATE NOT NULL,
    PRIMARY KEY (BookID, BranchID, CardNo)
);
GO

-- 4. Populate Tables with Sample Data

-- Populate PUBLISHER
INSERT INTO PUBLISHER (PublisherName, Address, Phone) VALUES
('DAW Books', '375 Hudson Street, New York, NY 10014', '212-366-2000'),
('Viking', '375 Hudson Street, New York, NY 10014', '212-366-2000'),
('Signet Classics', '375 Hudson Street, New York, NY 10014', '212-366-2000'),
('Chilton Books', 'Philadelphia, PA', '800-555-1212'),
('George Allen & Unwin', 'London, England', '44-20-7946-0000');

-- Populate LIBRARY_BRANCH
INSERT INTO LIBRARY_BRANCH (BranchName, Address) VALUES
('Sharpstown', '3218 W. Loop South, Houston, TX 77027'),
('Central', '500 McKinney St, Houston, TX 77002'),
('Saltaire', '123 Main St, Saltaire, NY 11706'),
('North County', '456 Oak Rd, St. Louis, MO 63101');

-- Populate BORROWER
INSERT INTO BORROWER (Name, Address, Phone) VALUES
('Joe Smith', '123 Elm St, Houston, TX 77001', '713-555-1212'),
('Jane Doe', '456 Maple St, Dallas, TX 75201', '214-555-1212'),
('Bob Brown', '789 Pine St, Austin, TX 78701', '512-555-1212'),
('Alice Green', '101 Cedar Ln, Saltaire, NY 11706', '631-555-1212'),
('Charlie White', '202 Birch Dr, St. Louis, MO 63101', '314-555-1212'),
('David Black', '303 Spruce Ct, Houston, TX 77002', '713-555-3434'),
('Eve Grey', '404 Walnut Ave, Central City, OH 44114', '216-555-5656'),
('Frank Red', '505 Cherry St, Boston, MA 02108', '617-555-7878'),
('Grace Blue', '606 Ash Way, Seattle, WA 98101', '206-555-9090'),
('Henry Gold', '707 Silver Blvd, Denver, CO 80201', '303-555-1111');

-- Populate BOOKS
INSERT INTO BOOKS (Title, PublisherName) VALUES
('The Lost Tribe', 'DAW Books'),
('It', 'Viking'),
('The Shining', 'Viking'),
('Doctor Sleep', 'Viking'),
('The Stand', 'Viking'),
('Misery', 'Viking'),
('Carrie', 'Viking'),
('Cujo', 'Viking'),
('The Green Mile', 'Signet Classics'),
('Dune', 'Chilton Books'),
('The Hobbit', 'George Allen & Unwin'),
('The Fellowship of the Ring', 'George Allen & Unwin'),
('The Two Towers', 'George Allen & Unwin'),
('The Return of the King', 'George Allen & Unwin'),
('1984', 'Signet Classics'),
('Animal Farm', 'Signet Classics'),
('Brave New World', 'Signet Classics'),
('Fahrenheit 451', 'Signet Classics'),
('The Great Gatsby', 'Signet Classics'),
('To Kill a Mockingbird', 'Signet Classics');

-- Populate BOOK_AUTHORS
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES
(1, 'Patrick Rothfuss'),
(2, 'Stephen King'),
(3, 'Stephen King'),
(4, 'Stephen King'),
(5, 'Stephen King'),
(6, 'Stephen King'),
(7, 'Stephen King'),
(8, 'Stephen King'),
(9, 'Stephen King'),
(10, 'Frank Herbert'),
(11, 'J.R.R. Tolkien'),
(12, 'J.R.R. Tolkien'),
(13, 'J.R.R. Tolkien'),
(14, 'J.R.R. Tolkien'),
(15, 'George Orwell'),
(16, 'George Orwell'),
(17, 'Aldous Huxley'),
(18, 'Ray Bradbury'),
(19, 'F. Scott Fitzgerald'),
(20, 'Harper Lee');

-- Populate BOOK_COPIES (20 books * 4 branches = 80 entries approx)
-- Giving 'The Lost Tribe' 5 copies at each branch as per common query test
INSERT INTO BOOK_COPIES (BookID, BranchID, Number_Of_Copies)
SELECT BookID, BranchID, 5
FROM BOOKS CROSS JOIN LIBRARY_BRANCH
WHERE Title = 'The Lost Tribe';

-- Giving other books random copies
INSERT INTO BOOK_COPIES (BookID, BranchID, Number_Of_Copies)
SELECT BookID, BranchID, 2
FROM BOOKS CROSS JOIN LIBRARY_BRANCH
WHERE Title != 'The Lost Tribe';

-- Populate BOOK_LOANS
-- Loans for Joe Smith at Sharpstown (Due Today for Query 4)
INSERT INTO BOOK_LOANS (BookID, BranchID, CardNo, DateOut, DueDate) VALUES
(1, 1, 100, CAST(GETDATE()-14 AS DATE), CAST(GETDATE() AS DATE)),
(2, 1, 100, CAST(GETDATE()-14 AS DATE), CAST(GETDATE() AS DATE));

-- More loans to ensure data for other queries
INSERT INTO BOOK_LOANS (BookID, BranchID, CardNo, DateOut, DueDate) VALUES
(3, 2, 101, CAST(GETDATE()-7 AS DATE), CAST(GETDATE()+7 AS DATE)),
(10, 2, 101, CAST(GETDATE()-7 AS DATE), CAST(GETDATE()+7 AS DATE)),
(11, 2, 101, CAST(GETDATE()-7 AS DATE), CAST(GETDATE()+7 AS DATE)),
(12, 2, 101, CAST(GETDATE()-7 AS DATE), CAST(GETDATE()+7 AS DATE)),
(13, 2, 101, CAST(GETDATE()-7 AS DATE), CAST(GETDATE()+7 AS DATE)),
(14, 2, 101, CAST(GETDATE()-7 AS DATE), CAST(GETDATE()+7 AS DATE)); -- Bob has > 5 books for Query 6

GO

-- 5. Verification Queries (The standard Assignment Queries)

-- 1. How many copies of the book "The Lost Tribe" are owned by each library branch?
SELECT LB.BranchName, BC.Number_Of_Copies
FROM BOOKS B
JOIN BOOK_COPIES BC ON B.BookID = BC.BookID
JOIN LIBRARY_BRANCH LB ON BC.BranchID = LB.BranchID
WHERE B.Title = 'The Lost Tribe';

-- 2. For each book authored by "Stephen King", retrieve the title and number of copies owned by "Central" branch.
SELECT B.Title, BC.Number_Of_Copies
FROM BOOKS B
JOIN BOOK_AUTHORS BA ON B.BookID = BA.BookID
JOIN BOOK_COPIES BC ON B.BookID = BC.BookID
JOIN LIBRARY_BRANCH LB ON BC.BranchID = LB.BranchID
WHERE BA.AuthorName = 'Stephen King' AND LB.BranchName = 'Central';

-- 3. Retrieve the names of all borrowers who do not have any books checked out.
SELECT Name
FROM BORROWER B
LEFT JOIN BOOK_LOANS BL ON B.CardNo = BL.CardNo
WHERE BL.CardNo IS NULL;

-- 4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, 
--    retrieve the book title, the borrower's name, and the borrower's address.
SELECT B.Title, BR.Name, BR.Address
FROM BOOK_LOANS BL
JOIN BOOKS B ON BL.BookID = B.BookID
JOIN BORROWER BR ON BL.CardNo = BR.CardNo
JOIN LIBRARY_BRANCH LB ON BL.BranchID = LB.BranchID
WHERE LB.BranchName = 'Sharpstown' AND BL.DueDate = CAST(GETDATE() AS DATE);

-- 5. For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
SELECT LB.BranchName, COUNT(BL.BookID) AS TotalLoans
FROM LIBRARY_BRANCH LB
LEFT JOIN BOOK_LOANS BL ON LB.BranchID = BL.BranchID
GROUP BY LB.BranchName;

-- 6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
SELECT BR.Name, BR.Address, COUNT(BL.BookID) AS BooksCheckedOut
FROM BORROWER BR
JOIN BOOK_LOANS BL ON BR.CardNo = BL.CardNo
GROUP BY BR.Name, BR.Address
HAVING COUNT(BL.BookID) > 5;

-- 7. For each book authored by "Stephen King", retrieve the title and the number of copies owned by "Central".
-- (Note: This is often a repetition of #2 or a slightly different phrasing in assignments)
SELECT B.Title, BC.Number_Of_Copies
FROM BOOKS B
JOIN BOOK_AUTHORS BA ON B.BookID = BA.BookID
JOIN BOOK_COPIES BC ON B.BookID = BC.BookID
JOIN LIBRARY_BRANCH LB ON BC.BranchID = LB.BranchID
WHERE BA.AuthorName = 'Stephen King' AND LB.BranchName = 'Central';
