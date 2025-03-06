-- Retrieve Menu by Category
SELECT m.Name AS MenuItemName, m.Price, m.Availability
FROM MenuItems m
JOIN LookupItems l ON m.CategoryID = l.LookupItemID
JOIN LookupTypes lt ON l.LookupTypeID = lt.LookupTypeID
-- Replace 'Vegan' with the actual category name
WHERE (lt.Name = 'Category' AND l.TypeName = 'Vegan' AND m.IsActive = 1);

