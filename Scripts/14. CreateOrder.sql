USE STGenetics;

-- Create a new stored procedure called 'CreateOrder' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'CreateOrder'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.CreateOrder
GO
CREATE PROCEDURE CreateOrder
    @CustomerId INT,
    @AnimalId INT,
    @Quantity INT
    
AS
BEGIN
    SET NOCOUNT ON;

    -- Variables
    DECLARE @UnitPrice DECIMAL(18, 2);
    DECLARE @TotalPrice DECIMAL(18, 2);
    DECLARE @TotalAmount DECIMAL(18, 2);
    DECLARE @Freight DECIMAL(18, 2) = 1000.00 ;
    DECLARE @Discount DECIMAL(18, 2) = 0.0;

    -- Calculate unit price and total price
    SELECT @UnitPrice = Price 
    FROM Animals 
    WHERE AnimalId = @AnimalId;

    SELECT @TotalPrice = @UnitPrice * @Quantity;

    -- Calculate discounts
    IF @Quantity > 50
        SET @Discount = @TotalPrice * 0.05;
    ELSE
        SET @Discount = 0;

    IF @Quantity > 200
        SET @Discount = @Discount + (@TotalPrice * 0.03);

    -- Calculate freight
    IF @Quantity > 300
        SET @Freight = 0;
    ELSE
        SET @Freight = 1000.00;

    -- Calculate total amount
    SET @TotalAmount = @TotalPrice - @Discount + @Freight;

    -- Insert order
    INSERT INTO Orders (CustomerId, TotalAmount, Freight, Discount)
    VALUES (@CustomerId, @TotalAmount, @Freight, @Discount);

    DECLARE @OrderId INT;
    SET @OrderId = SCOPE_IDENTITY();

    -- Insert order detail
    INSERT INTO OrderDetails (OrderId, AnimalId, Quantity, UnitPrice, TotalPrice)
    VALUES (@OrderId, @AnimalId, @Quantity, @UnitPrice, @TotalPrice);

    -- Build JSON response
    DECLARE @Json NVARCHAR(MAX);
    SET @Json = N'{
        "OrderId": ' + CAST(@OrderId AS NVARCHAR(10)) + ',
        "TotalAmount": ' + CAST(@TotalAmount AS NVARCHAR(20)) + '
    }';

    SELECT @Json;
END;
