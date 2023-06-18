-- Create a new table called '[OrderDetails]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[OrderDetails]', 'U') IS NOT NULL
DROP TABLE [dbo].[OrderDetails]
GO
CREATE TABLE OrderDetails
(
    OrderDetailId INT IDENTITY(1, 1) PRIMARY KEY,
    OrderId INT NOT NULL,
    AnimalId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18, 2) NOT NULL,
    TotalPrice DECIMAL(18, 2) NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) REFERENCES Orders (OrderId),
    CONSTRAINT FK_OrderDetails_Animals FOREIGN KEY (AnimalId) REFERENCES Animals (AnimalId)
);

GO