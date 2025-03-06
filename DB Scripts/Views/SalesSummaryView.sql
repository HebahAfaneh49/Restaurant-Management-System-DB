-- Sales Summary View
CREATE VIEW SalesSummary AS
SELECT mi.ItemID, mi.[Name] AS ItemName, li.TypeName AS Category, SUM(od.Quantity) AS TotalQuantitySold, SUM(od.Quantity * mi.Price) AS TotalRevenue
FROM OrderDetails od
JOIN MenuItems mi ON od.ItemID = mi.ItemID
JOIN LookupItems li ON mi.CategoryID = li.LookupItemID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.Status = 'Completed'
GROUP BY mi.ItemID, mi.[Name], li.TypeName;

