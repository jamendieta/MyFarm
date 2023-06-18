USE STGenetics;

-- Create a new stored procedure called 'FilterAnimals' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'FilterAnimals'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.FilterAnimals
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.FilterAnimals
    @AnimalId INT = NULL,
    @Name NVARCHAR(50) = NULL,
    @Sex BIT = NULL,
    @Status BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT AnimalId, Name, Breed, BirthDate, Sex, Price, Status
    FROM Animals
    WHERE
        (@AnimalId IS NULL OR AnimalId = @AnimalId)
        AND (@Name IS NULL OR Name LIKE '%' + @Name + '%')
        AND (@Sex IS NULL OR Sex = @Sex)
        AND (@Status IS NULL OR Status = @Status);
END
GO