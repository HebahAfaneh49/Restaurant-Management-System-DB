-- Insert LookupTypes (e.g., "PersonRole", "City", "Nationality", "Category")
INSERT INTO LookupTypes ([Name]) VALUES ('PersonRole'), ('City'), ('Nationality'), ('Category');

-- Insert LookupItems for PersonRole (Admin, Staff, Customer)
INSERT INTO LookupItems (LookupTypeID, TypeName)
VALUES 
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'PersonRole'), 'Admin'),
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'PersonRole'), 'Staff'),
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'PersonRole'), 'Customer');

-- Insert LookupItems for City (e.g., "New York", "London", "Paris")
INSERT INTO LookupItems (LookupTypeID, TypeName)
VALUES 
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'City'), 'Amman'),
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'City'), 'Jerash'),
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'City'), 'Ajloun');

-- Insert LookupItems for Nationality (e.g., "USA", "UK", "France")
INSERT INTO LookupItems (LookupTypeID, TypeName)
VALUES 
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Nationality'), 'Jordanian'),
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Nationality'), 'Palestinian'),
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Nationality'), 'Jordanian');

-- Insert LookupItems for Category (e.g., "Vegan", "Non-Vegan", "Gluten-Free")
INSERT INTO LookupItems (LookupTypeID, TypeName)
VALUES 
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Category'), 'Vegan'),
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Category'), 'Non-Vegan'),
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Category'), 'Gluten-Free');

-- Insert ContactDetails (Phone numbers, Address, City, Nationality)
INSERT INTO ContactDetails (PhoneNumber1, PhoneNumber2, [Address], CityId, NationalityId, CreateBy, UpdateBy)
VALUES 
('0791236540', '0773456789', '123 Main St, Amman', 
        (SELECT TOP 1 LookupItemID FROM LookupItems WHERE TypeName = 'Amman' AND LookupTypeID = (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'City')), 
        (SELECT TOP 1 LookupItemID FROM LookupItems WHERE TypeName = 'Jordanian' AND LookupTypeID = (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Nationality')) , 
    'Admin', 'Admin'),
('0782345679', '0783456790', '456 High St, Jerash', 
        (SELECT TOP 1 LookupItemID FROM LookupItems WHERE TypeName = 'Jerash' AND LookupTypeID = (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'City')), 
        (SELECT TOP 1 LookupItemID FROM LookupItems WHERE TypeName = 'Palestinian' AND LookupTypeID = (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Nationality')) , 
    'Admin', 'Admin');


-- Insert Person (linking to ContactDetails)
INSERT INTO Person (ContactDetailsId, PersonRoleID, CreateBy, UpdateBy, Fullname, Email, [Password], Bio, [Image], Role)
VALUES 
(1, (SELECT LookupItemID FROM LookupItems WHERE TypeName = 'Admin' AND LookupTypeID = (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'PersonRole')), 
    'Admin', 'Admin', 'John Doe', 'john.doe@example.com', 'password123', 'Manager at the restaurant', 'image1.jpg', 'Admin'),
(2, (SELECT LookupItemID FROM LookupItems WHERE TypeName = 'Customer' AND LookupTypeID = (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'PersonRole')), 
    'Admin', 'Admin', 'Jane Smith', 'jane.smith@example.com', 'password123', 'Regular customer', 'image2.jpg', 'Customer');

-- Insert Tables (e.g., 10 tables in the restaurant)
INSERT INTO Tables (Capacity)
VALUES 
(4), 
(2), 
(6), 
(4), 
(4), 
(2), 
(6), 
(4), 
(2), 
(4);

-- Insert Reservations (make sure the customers are linked)
INSERT INTO Reservations (CustomerID, TableID, NumberOfGuests, TableNumber, ReservationDate, CreateBy, UpdateBy)
VALUES 
(2, 1, 2, 1, '2025-03-10 19:00:00', 'Admin', 'Admin'),
(2, 2, 4, 2, '2025-03-15 20:00:00', 'Admin', 'Admin');

-- Insert MenuItems (e.g., Vegan, Non-Vegan, Gluten-Free items)
INSERT INTO MenuItems (CategoryID, CreateBy, UpdateBy, [Name], Price, Availability, Discounts, [Description], [Image])
VALUES 
((SELECT LookupItemID FROM LookupItems WHERE TypeName = 'Vegan' AND LookupTypeID = (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Category')), 
    'Admin', 'Admin', 'Vegan Burger', 10.00, 1, 0, 'A delicious vegan burger', 'vegan_burger.jpg'),
((SELECT LookupItemID FROM LookupItems WHERE TypeName = 'Non-Vegan' AND LookupTypeID = (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Category')), 
    'Admin', 'Admin', 'Beef Burger', 12.00, 1, 0, 'A tasty beef burger', 'beef_burger.jpg');

-- Insert Orders (linking to Person and Tables)
INSERT INTO Orders (CustomerID, TableID, OrderDate, Status, TotalAmount, CreateBy, UpdateBy)
VALUES 
(2, 1, '2025-03-10 19:00:00', 'Pending', 20.00, 'Admin', 'Admin'),
(2, 2, '2025-03-10 20:00:00', 'Pending', 24.00, 'Admin', 'Admin');

-- Insert OrderDetails (linking to Orders and MenuItems)
INSERT INTO OrderDetails (OrderID, ItemID, Quantity)
VALUES 
(1, 1, 2),  -- Order 1: Vegan Burger, 2 quantity
(1, 2, 1);  -- Order 1: Beef Burger, 1 quantity


-- Insert Attendance (for Staff)
INSERT INTO Attendance (StaffID, AttendanceDate, Status) 
VALUES 
((SELECT PersonId FROM Person WHERE Fullname = 'Alice Brown'), '2025-03-01', 'Present'),
((SELECT PersonId FROM Person WHERE Fullname = 'Alice Brown'), '2025-03-02', 'Late'),
((SELECT PersonId FROM Person WHERE Fullname = 'Alice Brown'), '2025-03-03', 'Absent');

INSERT INTO LookupItems (LookupTypeID, TypeName) 
VALUES 
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'City'), 'Amman'),
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'City'), 'Irbid');

INSERT INTO LookupItems (LookupTypeID, TypeName) 
VALUES 
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Nationality'), 'Jordanian'),
((SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Nationality'), 'Jordanian');


-- Insert additional ContactDetails 
INSERT INTO ContactDetails (PhoneNumber1, PhoneNumber2, [Address], CityId, NationalityId, CreateBy, UpdateBy)
VALUES 
('0799874563', '0777412589', '123 Main St, Amman', 
    (SELECT TOP 1 LookupItemID FROM LookupItems WHERE TypeName = 'Amman' AND LookupTypeID = 
        (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'City')), 
    (SELECT TOP 1 LookupItemID FROM LookupItems WHERE TypeName = 'Jordanian' AND LookupTypeID = 
        (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Nationality')), 
'Admin', 'Admin'),
('0782345689', '0783456791', '456 High St, Irbid', 
    (SELECT TOP 1 LookupItemID FROM LookupItems WHERE TypeName = 'Irbid' AND LookupTypeID = 
        (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'City')), 
    (SELECT TOP 1 LookupItemID FROM LookupItems WHERE TypeName = 'Jordanian' AND LookupTypeID = 
        (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'Nationality')), 
'Admin', 'Admin');


-- Insert Person for Staff with Specific Role & Customer 
INSERT INTO Person (ContactDetailsId, PersonRoleID, CreateBy, UpdateBy, Fullname, Email, [Password], IsActive, Role) 
VALUES
(5, (SELECT LookupItemID FROM LookupItems WHERE TypeName = 'Staff' AND LookupTypeID = (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'PersonRole')), 
     'Admin', 'Admin', 'John Doe', 'john@example.com', 'password123', 1, 'Chef'),
(6,(SELECT LookupItemID FROM LookupItems WHERE TypeName = 'Staff' AND LookupTypeID = (SELECT LookupTypeID FROM LookupTypes WHERE [Name] = 'PersonRole')), 
     'Admin', 'Admin', 'James Smith', 'james@example.com', 'password123', 1, 'Server'); 

--SELECT * FROM Person;

-- Insert Dummy Data into Feedback Table
INSERT INTO Feedback (CustomerID, Rating, Comments, CreateBy, UpdateBy)
VALUES 
(2, 5, 'Excellent service and great food! Highly recommend.', 'Admin', 'Admin'),
(2, 4, 'Good experience, but the food took a little longer to arrive.', 'Admin', 'Admin'),
(2, 3, 'The food was okay, but the staff seemed distracted.', 'Admin', 'Admin');

--SELECT * FROM Feedback;
