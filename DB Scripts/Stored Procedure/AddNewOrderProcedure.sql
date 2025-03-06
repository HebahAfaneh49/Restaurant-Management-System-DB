USE [E-Restaurant Management System]
CREATE TYPE OrderItemType AS TABLE (
    ItemID INT,
    Quantity INT
);


-- Add New Order
CREATE PROCEDURE AddNewOrder
@CustomerID INT,
@TableID INT,
@Items OrderItemType READONLY,  -- Pass items as a table parameter
@CreatedBy VARCHAR(MAX)
AS
BEGIN
SET NOCOUNT ON;   
DECLARE @OrderID INT, @TotalAmount DECIMAL(10,2) = 0;

-- Insert into Orders table
INSERT INTO Orders (CustomerID, TableID, OrderDate, Status, TotalAmount, CreateBy)
VALUES (@CustomerID, @TableID, GETDATE(), 'Pending', 0, @CreatedBy);

-- Get the newly inserted OrderID
SET @OrderID = SCOPE_IDENTITY();

-- Insert items into OrderDetails and calculate total amount
INSERT INTO OrderDetails (OrderID, ItemID, Quantity)
SELECT @OrderID, ItemID, Quantity FROM @Items;

-- Calculate total amount
SELECT @TotalAmount = SUM(od.Quantity * mi.Price)
FROM OrderDetails od
JOIN MenuItems mi ON od.ItemID = mi.ItemID
WHERE od.OrderID = @OrderID;

-- Update total amount in Orders table
UPDATE Orders
SET TotalAmount = @TotalAmount
WHERE OrderID = @OrderID;

PRINT 'Order added successfully with ID: ' + CAST(@OrderID AS VARCHAR);
END;
