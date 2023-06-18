USE STGenetics;

-- Generate random animal names
DECLARE @Names TABLE (Id INT IDENTITY(1,1), Name NVARCHAR(50))
INSERT INTO @Names (Name)
VALUES ('Max'), ('Bella'), ('Charlie'), ('Lucy'), ('Cooper'), ('Luna'), ('Max'), ('Daisy'), ('Rocky'), ('Sadie')

-- Generate random animal breeds
DECLARE @Breeds TABLE (Id INT IDENTITY(1,1), Breed NVARCHAR(50))
INSERT INTO @Breeds (Breed)
VALUES ('Labrador Retriever'), ('German Shepherd'), ('Golden Retriever'), ('Bulldog'), ('Beagle'), ('Poodle'), ('Rottweiler')

-- Generate 5,000 random animals
DECLARE @Counter INT = 1

WHILE @Counter <= 5000
BEGIN
    DECLARE @Name NVARCHAR(50)
    DECLARE @Breed NVARCHAR(50)
    DECLARE @BirthDate DATE
    DECLARE @Sex BIT
    DECLARE @Price DECIMAL(18, 2)
    DECLARE @Status BIT

    -- Generate random values for each animal
    SELECT TOP 1 @Name = Name FROM @Names ORDER BY NEWID()
    SELECT TOP 1 @Breed = Breed FROM @Breeds ORDER BY NEWID()
    SET @BirthDate = DATEADD(DAY, -FLOOR(RAND() * 365 * 10), GETDATE())
    SET @Sex = CAST((CASE WHEN RAND() < 0.5 THEN 0 ELSE 1 END) AS BIT)
    SET @Price = ROUND(RAND() * 1000, 2)
    SET @Status = CAST((CASE WHEN RAND() < 0.5 THEN 0 ELSE 1 END) AS BIT)

    -- Insert the animal into the table
    INSERT INTO Animals (Name, Breed, BirthDate, Sex, Price, Status)
    VALUES (@Name, @Breed, @BirthDate, @Sex, @Price, @Status)

    SET @Counter = @Counter + 1
END