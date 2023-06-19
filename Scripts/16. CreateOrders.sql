USE STGenetics;
GO

-- Create a new stored procedure called 'CreateOrders' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'CreateOrders'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.CreateOrders;
GO

-- Create the modified stored procedure 'CreateOrders' that accepts a JSON input
CREATE PROCEDURE CreateOrders
    @JsonOrders NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Variables
    DECLARE @UnitPrice DECIMAL(18, 2);
    DECLARE @TotalPrice DECIMAL(18, 2);
    DECLARE @TotalAmount DECIMAL(18, 2);
    DECLARE @Freight DECIMAL(18, 2) = 1000.00;
    DECLARE @Discount DECIMAL(18, 2) = 0.0;

    -- Temporary table to store the results
    CREATE TABLE #TempOrders
    (
        OrderId INT,
        TotalAmount DECIMAL(18, 2)
    );

    -- Validate if the same animal is being purchased multiple times
    IF EXISTS (
        SELECT CustomerId, AnimalId
        FROM OPENJSON(@JsonOrders)
        WITH (
            CustomerId INT,
            AnimalId INT,
            Quantity INT
        )
        GROUP BY CustomerId, AnimalId
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR('Duplicate animal purchases detected. Please ensure each animal is purchased only once.', 16, 1);
        RETURN;
    END;

    -- Process the JSON input and insert the orders
    INSERT INTO Orders (CustomerId, TotalAmount, Freight, Discount)
    OUTPUT INSERTED.OrderId, INSERTED.TotalAmount INTO #TempOrders
    SELECT CustomerId, 0, @Freight, @Discount
    FROM OPENJSON(@JsonOrders)
    WITH (
        CustomerId INT,
        AnimalId INT,
        Quantity INT
    );

    -- Update the TotalAmount for each order
    UPDATE t
    SET TotalAmount = 
    (
        SELECT SUM(od.Quantity * a.Price) 
        FROM OPENJSON(@JsonOrders)
        WITH (
            CustomerId INT,
            AnimalId INT,
            Quantity INT
        ) od
        INNER JOIN Animals a ON od.AnimalId = a.AnimalId
        WHERE t.OrderId = od.CustomerId
    )
    FROM #TempOrders t;

    -- Calculate discounts and freight for each order
    UPDATE t
    SET t.Discount =
    (
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM OPENJSON(@JsonOrders)
                WITH (
                    CustomerId INT,
                    AnimalId INT,
                    Quantity INT
                ) od
                WHERE t.OrderId = od.CustomerId
                AND od.Quantity > 50
            )
            THEN t.TotalAmount * 0.05
            ELSE 0
        END
    ),
    t.Freight =
    (
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM OPENJSON(@JsonOrders)
                WITH (
                    CustomerId INT,
                    AnimalId INT,
                    Quantity INT
                ) od
                WHERE t.OrderId = od.CustomerId
                AND od.Quantity <= 300
            )
            THEN 1000.00
            ELSE 0
        END
    )
    FROM #TempOrders t;

    -- Calculate total amount for each order
    UPDATE t
    SET TotalAmount = TotalAmount - t.Discount + t.Freight
    FROM #TempOrders t;

    -- Return the order details
    SELECT OrderId, TotalAmount
    FROM #TempOrders;

    -- Clean up temporary table
    DROP TABLE #TempOrders;
END;
