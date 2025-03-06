-- Daily Sales Report
SELECT mi.Name AS MenuItemName, lm.TypeName AS CategoryName, SUM(od.Quantity * mi.Price) AS TotalSales
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN MenuItems mi ON od.ItemID = mi.ItemID
JOIN LookupItems lm ON mi.CategoryID = lm.LookupItemID
JOIN LookupTypes lt ON lm.LookupTypeID = lt.LookupTypeID
-- Choose date
WHERE (o.OrderDate = '2025-03-06' AND o.Status = 'Completed')
GROUP BY mi.Name, lm.TypeName;
