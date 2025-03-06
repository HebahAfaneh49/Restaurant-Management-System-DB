-- Generate Staff Report
CREATE PROCEDURE GenerateStaffReport
@StartDate DATE,
@EndDate DATE
AS
BEGIN
SET NOCOUNT ON;

SELECT p.PersonId, p.Fullname AS StaffName, p.Role, 
COUNT(a.AttendanceID) AS TotalAttendance,
SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) AS DaysPresent,
SUM(CASE WHEN a.Status = 'Absent' THEN 1 ELSE 0 END) AS DaysAbsent,
SUM(CASE WHEN a.Status = 'Late' THEN 1 ELSE 0 END) AS DaysLate
FROM Attendance a
JOIN Person p ON a.StaffID = p.PersonId
WHERE a.AttendanceDate BETWEEN @StartDate AND @EndDate
GROUP BY p.PersonId, p.Fullname, p.Role
ORDER BY DaysAbsent ASC, DaysLate ASC;
END;
