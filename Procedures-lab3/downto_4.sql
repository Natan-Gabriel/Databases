CREATE PROCEDURE downto_4
AS
BEGIN
	ALTER TABLE Timetable
	drop CONSTRAINT Timetable_c
	PRINT 'Remove candidate key'
END
GO
EXEC downto_4
