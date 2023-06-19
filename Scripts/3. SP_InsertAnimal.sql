USE STGenetics
-- Create a new stored procedure called 'InsertAnimal' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'InsertAnimal'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.InsertAnimal
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.InsertAnimal
    @Name NVARCHAR(50),
    @Breed NVARCHAR(50),
    @BirthDate DATE,
    @Sex BIT,
    @Price DECIMAL(18, 2),
    @Status BIT
AS
BEGIN
    INSERT INTO [dbo].[Animals] ([Name], [Breed], [BirthDate], [Sex], [Price], [Status])
    VALUES (@Name, @Breed, @BirthDate, @Sex, @Price, @Status)
END
GO