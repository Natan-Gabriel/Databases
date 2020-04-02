CREATE PROCEDURE upto_6
AS
BEGIN
	ALTER TABLE Timetable
	ADD constraint fk_Timetable FOREIGN KEY(AId) REFERENCES Aircraft(AId)
	Print 'Add foreign key'

END
GO
EXEC upto_6

select* from Timetable