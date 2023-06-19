USE STGenetics;

-- Generate and insert 5,000 animal records
DECLARE @counter INT = 1;

WHILE @counter <= 5000
BEGIN
    DECLARE @breed VARCHAR(50);

    -- Assigning different breeds based on a counter modulus
    IF @counter % 7 = 0
        SET @breed = 'Holstein';
    ELSE IF @counter % 7 = 1
        SET @breed = 'Angus';
    ELSE IF @counter % 7 = 2
        SET @breed = 'Hereford';
    ELSE IF @counter % 7 = 3
        SET @breed = 'Brahman';
    ELSE IF @counter % 7 = 4
        SET @breed = 'Limousin';
    ELSE IF @counter % 7 = 5
        SET @breed = 'Jersey';
    ELSE
        SET @breed = 'Simmental';

    INSERT INTO Animals (Name, Breed, BirthDate, Sex, Price, Status)
    VALUES (
        'Animal' + CAST(@counter AS VARCHAR(10)),
        @breed,
        DATEADD(DAY, -FLOOR(RAND()*(365*10)), GETDATE()), -- Random birth date within the last 10 years
        CASE WHEN @counter % 2 = 0 THEN 1 ELSE 0 END, -- 1 for Male (Bull), 0 for Female (Cow)
        CAST((RAND()*(1000-100)+100) AS DECIMAL(18,2)), -- Random price between 100 and 1000
        CASE WHEN @counter % 5 = 0 THEN 0 ELSE 1 END -- 0 for Inactive, 1 for Active (Inactive for every 5th record)
    );

    SET @counter = @counter + 1;
END;