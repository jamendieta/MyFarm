USE STGenetics

-- Create a new table called '[Animals]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Animals]', 'U') IS NOT NULL
DROP TABLE [dbo].[Animals]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Animals]
(
    [AnimalId] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [Name] NVARCHAR(50) NOT NULL,
    [Breed] NVARCHAR(50) NOT NULL,
    [BirthDate] DATE NOT NULL,
    [Sex] BIT NOT NULL,
    [Price] DECIMAL(18, 2) NOT NULL,
    [Status] BIT NOT NULL
);
GO