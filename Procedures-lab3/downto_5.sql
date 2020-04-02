CREATE PROCEDURE downto_5
AS
BEGIN
	ALTER TABLE Timetable
	DROP CONSTRAINT fk_Timetable
	Print 'Remove foreign key'

END
GO
EXEC downto_5

select* from Timetable