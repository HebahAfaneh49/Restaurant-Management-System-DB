-- Update Menu Availability
CREATE PROCEDURE UpdateMenuAvailability
@ItemID INT,
@Availability BIT
AS
BEGIN
SET NOCOUNT ON;
UPDATE MenuItems
SET [Availability] = @Availability
WHERE ItemID = @ItemID;

PRINT 'Menu item availability updated successfully!';
END;
