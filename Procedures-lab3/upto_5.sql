CREATE PROCEDURE upto_5
AS
BEGIN
	ALTER TABLE Timetable
	ADD CONSTRAINT Timetable_c UNIQUE(TimetableCode);
	PRINT 'Add candidate key'
END
GO
EXEC upto_5
