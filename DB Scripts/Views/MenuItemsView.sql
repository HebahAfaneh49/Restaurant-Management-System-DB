-- Available Menu Items View
CREATE VIEW AvailableMenuItems AS
SELECT mi.ItemID, mi.[Name] AS ItemName, li.TypeName AS Category, mi.Price 
FROM MenuItems mi
JOIN LookupItems li ON mi.CategoryID = li.LookupItemID
WHERE mi.[Availability] = 1;
