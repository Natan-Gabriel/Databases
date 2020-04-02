CREATE PROCEDURE downto_3
AS
BEGIN
	ALTER TABLE Timetable
	DROP constraint PK_Timetable
	PRINT 'Dropped PK for Timetable'
END

GO

EXEC downto_3

select* from Timetable