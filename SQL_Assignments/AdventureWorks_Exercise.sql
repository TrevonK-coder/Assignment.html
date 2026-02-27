/* =============================================================
   ADVENTUREWORKS STORED PROCEDURE ASSIGNMENT
   Task: Create, Execute, and Drop a Stored Procedure
   Path: ...\SQL_Assignments\AdventureWorks_Exercise.sql
   ============================================================= */

-- 1. Ensure we are using the restored database
USE AdventureWorks2017;
GO

-- 2. Create the Stored Procedure
-- This logic creates a procedure that returns person names
CREATE PROCEDURE dbo.uspGetPersonContacts
AS
BEGIN
    SELECT FirstName, LastName, MiddleName
    FROM Person.Person;
END;
GO

-- 3. Execute the Stored Procedure
EXEC dbo.uspGetPersonContacts;

-- 4. Cleanup (Keep commented out so instructor sees the code)
-- DROP PROCEDURE dbo.uspGetPersonContacts;