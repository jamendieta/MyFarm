
USE STGenetics;

-- Create a new stored procedure called 'GetOrder' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'GetOrder'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.GetOrder
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.GetOrder
    @OrderId INT
AS
BEGIN
    SELECT
    animals.Name AnimalName,
    animals.Breed AnimalBreed,
    animals.Sex AnimalSex,
    customers.FirstName CustomerName,
    customers.LastName CustomerLastName,
    customers.Email CustomerEmail,
    customers.PhoneNumber CustomerPhone,
    ordersDetails.Quantity OrderQuantity,
    ordersDetails.UnitPrice OrderUnits,
    ordersDetails.TotalPrice OrderTotal,
    orders.Discount OrderDiscount,
    orders.Freight OrderFreight,
    orders.TotalAmount OrderTotalAmount
    FROM Orders orders WITH(NOLOCK)
    INNER JOIN OrderDetails ordersDetails
        ON ordersDetails.OrderId = orders.OrderId
    INNER JOIN Animals animals
        ON ordersDetails.AnimalId = animals.AnimalId
    INNER JOIN Customers customers
        ON orders.CustomerId = customers.CustomerId
    WHERE orders.OrderId = @OrderId
END
GO