CREATE PROCEDURE downto_0
AS
BEGIN
	ALTER TABLE Flight
	Alter COLUMN LengthOfFlight int
	PRINT 'Changed the type of LengthOfFlight to int'
END
GO
EXEC downto_0