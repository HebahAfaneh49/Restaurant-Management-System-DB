CREATE DATABASE [E-Restaurant Management System]

USE [E-Restaurant Management System]

CREATE TABLE LookupTypes (
LookupTypeID INT PRIMARY KEY IDENTITY(1,1),
[Name] VARCHAR(100) NOT NULL,  -- Name of the lookup type, e.g., "PersonRole"(Admin, Staff, Customer), "City", "Nationality", "Category"
);

CREATE TABLE LookupItems (
LookupItemID INT PRIMARY KEY IDENTITY(1,1),
LookupTypeID INT NOT NULL,
TypeName VARCHAR(100) NOT NULL,
FOREIGN KEY (LookupTypeID) REFERENCES LookupTypes(LookupTypeID) ON DELETE CASCADE
);

CREATE TABLE ContactDetails(
ContactId INT PRIMARY KEY IDENTITY(1,1),
PhoneNumber1 VARCHAR(10) CHECK (PhoneNumber1 LIKE '07%') NOT NULL, 
PhoneNumber2 VARCHAR(10) CHECK (PhoneNumber2 LIKE '07%'), 
[Address] VARCHAR(MAX) NOT NULL,
CityId INT NOT NULL,
NationalityId INT NOT NULL,
FacebookLink VARCHAR(MAX), 
WhatsappLink VARCHAR(MAX),
CreateBy VARCHAR(MAX) NOT NULL, 
UpdateBy VARCHAR(MAX), 
IsActive BIT DEFAULT 1, 
UpdateDate DATE, 
CreationDate DATE DEFAULT GETDATE(),
FOREIGN KEY (CityId) REFERENCES LookupItems(LookupItemID),
FOREIGN KEY (NationalityId) REFERENCES LookupItems(LookupItemID),
CONSTRAINT Unique_Table_ContactDetails UNIQUE (PhoneNumber1)
);

CREATE TABLE Person (
PersonId INT PRIMARY KEY IDENTITY(1,1),
ContactDetailsId INT NOT NULL,
PersonRoleID INT NOT NULL,
CreateBy VARCHAR(MAX) NOT NULL, 
UpdateBy VARCHAR(MAX), 
IsActive BIT DEFAULT 1, 
UpdateDate DATE, 
CreationDate DATE DEFAULT GETDATE(),
Fullname VARCHAR(MAX) NOT NULL, 
Email VARCHAR(200) CHECK (Email LIKE '%@%.%') NOT NULL, 
[Password] VARCHAR(16) NOT NULL,
Bio VARCHAR(MAX), 
[Image] VARCHAR(MAX),
[Role] VARCHAR(50), 
ShiftTiming DATE, 
Attendance VARCHAR(50),
FOREIGN KEY (ContactDetailsId) REFERENCES ContactDetails(ContactId) ON DELETE CASCADE,
FOREIGN KEY (PersonRoleID) REFERENCES LookupItems(LookupItemID) ON DELETE CASCADE,
CONSTRAINT Unique_Table_Person UNIQUE (ContactDetailsId, Email, [Password])
);

CREATE TABLE MenuItems (
ItemID INT PRIMARY KEY IDENTITY(1,1),
CategoryID INT NOT NULL,
CreateBy VARCHAR(MAX) NOT NULL, 
UpdateBy VARCHAR(MAX), 
IsActive BIT DEFAULT 1, 
UpdateDate DATE, 
CreationDate DATE DEFAULT GETDATE(),
[Name] VARCHAR(100) NOT NULL,
Price DECIMAL(10,2) CHECK (Price > 0) NOT NULL,
[Availability] BIT DEFAULT 1,
Discounts DECIMAL(10,2), 
[Description] VARCHAR(MAX), 
[Image] VARCHAR(MAX),
FOREIGN KEY (CategoryID) REFERENCES LookupItems(LookupItemID)
);

CREATE TABLE Tables (
TableID INT PRIMARY KEY IDENTITY(1,1),
Capacity INT CHECK (Capacity > 0) NOT NULL
);

CREATE TABLE Reservations (
ReservationID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT NOT NULL,
TableID INT NOT NULL,
NumberOfGuests INT CHECK (NumberOfGuests > 0) NOT NULL,
TableNumber INT CHECK (TableNumber > 0) NOT NULL,
ReservationDate DATETIME NOT NULL,
CreateBy VARCHAR(MAX) NOT NULL, 
UpdateBy VARCHAR(MAX), 
IsActive BIT DEFAULT 1, 
UpdateDate DATE, 
CreationDate DATE DEFAULT GETDATE(),
FOREIGN KEY (CustomerID) REFERENCES Person(PersonId) ON DELETE CASCADE,
FOREIGN KEY (TableID) REFERENCES Tables(TableID) ON DELETE CASCADE,
CONSTRAINT Unique_Table_Reservation UNIQUE (TableID, ReservationDate)
);

CREATE TABLE Orders (
OrderID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT NULL,
TableID INT,
OrderDate DATETIME DEFAULT GETDATE(),
Status VARCHAR(50) CHECK (Status IN ('Pending', 'Completed', 'Cancelled')) DEFAULT 'Pending',
TotalAmount DECIMAL(10,2) DEFAULT 0,
CreateBy VARCHAR(MAX) NOT NULL, 
UpdateBy VARCHAR(MAX), 
IsActive BIT DEFAULT 1, 
UpdateDate DATE, 
CreationDate DATE DEFAULT GETDATE(),
FOREIGN KEY (CustomerID) REFERENCES Person(PersonId) ON DELETE SET NULL,
FOREIGN KEY (TableID) REFERENCES Tables(TableID) ON DELETE CASCADE
);

CREATE TABLE OrderDetails (
OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
OrderID INT,
ItemID INT,
Quantity INT CHECK (Quantity > 0) NOT NULL,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
FOREIGN KEY (ItemID) REFERENCES MenuItems(ItemID) ON DELETE CASCADE
);

CREATE TABLE Attendance (
AttendanceID INT PRIMARY KEY IDENTITY(1,1),
StaffID INT,
AttendanceDate DATE NOT NULL,
Status VARCHAR(50) CHECK (Status IN ('Present', 'Absent', 'Late')) NOT NULL,
FOREIGN KEY (StaffID) REFERENCES Person(PersonId) ON DELETE CASCADE
);

CREATE TABLE Feedback (
FeedbackID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT,
Rating INT CHECK (Rating BETWEEN 1 AND 5) NOT NULL DEFAULT 1,
Comments VARCHAR(500),
CreateBy VARCHAR(MAX) NOT NULL, 
UpdateBy VARCHAR(MAX), 
IsActive BIT DEFAULT 1, 
UpdateDate DATE, 
CreationDate DATE DEFAULT GETDATE(),
FOREIGN KEY (CustomerID) REFERENCES Person(PersonId) ON DELETE CASCADE
);

