-- Reservation Schedule
SELECT r.ReservationID, p.Fullname AS CustomerName, r.TableNumber, r.NumberOfGuests, r.ReservationDate, t.Capacity AS TableCapacity
FROM Reservations r
JOIN Person p ON r.CustomerID = p.PersonId
JOIN Tables t ON r.TableID = t.TableID
WHERE (r.ReservationDate = '2025-03-06' AND r.IsActive = 1); -- Choose any date
