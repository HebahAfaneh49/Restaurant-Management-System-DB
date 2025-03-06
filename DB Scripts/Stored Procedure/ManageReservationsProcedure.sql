-- Manage Reservations
CREATE PROCEDURE ManageReservation
@ReservationID INT = NULL, -- New reservation; otherwise, it's an update
@CustomerID INT,
@TableID INT,
@NumberOfGuests INT,
@TableNumber INT,
@ReservationDate DATETIME,
@CreatedBy VARCHAR(MAX)
AS
BEGIN
SET NOCOUNT ON;
-- Ensure no table is double-booked at the same time
IF EXISTS (
SELECT 1 FROM Reservations
WHERE (TableID = @TableID AND ReservationDate = @ReservationDate
AND (@ReservationID IS NULL OR ReservationID <> @ReservationID))
)

IF @ReservationID IS NULL
BEGIN
-- Insert new reservation
INSERT INTO Reservations (CustomerID, TableID, NumberOfGuests, TableNumber, ReservationDate, CreateBy)
VALUES (@CustomerID, @TableID, @NumberOfGuests, @TableNumber, @ReservationDate, @CreatedBy);
PRINT 'New reservation added successfully!';
END

ELSE
BEGIN
-- Update existing reservation
UPDATE Reservations
SET CustomerID = @CustomerID,
TableID = @TableID,
NumberOfGuests = @NumberOfGuests,
TableNumber = @TableNumber,
ReservationDate = @ReservationDate,
UpdateBy = @CreatedBy,
UpdateDate = GETDATE()
WHERE ReservationID = @ReservationID;
PRINT 'Reservation updated successfully!';
END

END;
