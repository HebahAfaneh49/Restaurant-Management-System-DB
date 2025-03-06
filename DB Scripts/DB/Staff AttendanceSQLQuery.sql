-- Staff Attendance
SELECT p.Fullname AS StaffName, a.AttendanceDate, a.Status AS AttendanceStatus
FROM Attendance a
JOIN Person p ON a.StaffID = p.PersonId
WHERE (a.AttendanceDate BETWEEN '2025-03-01' AND '2025-03-06')  -- Choose any date you want
ORDER BY a.AttendanceDate;
