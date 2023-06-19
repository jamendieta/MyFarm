USE STGenetics;
-- Create a new stored procedure called 'UpdateAnimal' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'UpdateAnimal'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.UpdateAnimal
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.UpdateAnimal
    @AnimalId INT,
    @Name NVARCHAR(50),
    @Breed NVARCHAR(50),
    @BirthDate DATE,
    @Sex BIT,
    @Price DECIMAL(18, 2),
    @Status BIT
AS
BEGIN
    UPDATE [dbo].[Animals]
    SET [Name] = @Name,
        [Breed] = @Breed,
        [BirthDate] = @BirthDate,
        [Sex] = @Sex,
        [Price] = @Price,
        [Status] = @Status
    WHERE [AnimalId] = @AnimalId;
END
GO