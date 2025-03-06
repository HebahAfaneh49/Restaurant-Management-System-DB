-- Daily Reservations View
CREATE VIEW DailyReservations AS
SELECT r.ReservationID, r.TableNumber, r.ReservationDate, p.Fullname AS CustomerName, c.PhoneNumber1 AS ContactNumber, c.[Address] AS CustomerAddress
FROM Reservations r
JOIN Person p ON r.CustomerID = p.PersonId
JOIN ContactDetails c ON p.ContactDetailsId = c.ContactId
WHERE CAST(r.ReservationDate AS DATE) = CAST(GETDATE() AS DATE);

