CREATE PROCEDURE upto_4
AS
BEGIN
	ALTER TABLE Timetable
	ADD CONSTRAINT PK_Timetable PRIMARY KEY(TId)
	PRINT 'Added PK for Timetable'
END

GO

EXEC upto_4

select* from Timetable