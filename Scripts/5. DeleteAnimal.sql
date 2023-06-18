USE STGenetics;

-- Create a new stored procedure called 'DeleteAnimal' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'DeleteAnimal'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.DeleteAnimal
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.DeleteAnimal
    @AnimalId INT
AS
BEGIN
    DELETE FROM [dbo].[Animals]
    WHERE [AnimalId] = @AnimalId;
END
GO
