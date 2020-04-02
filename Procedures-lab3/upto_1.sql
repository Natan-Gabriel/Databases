CREATE PROCEDURE upto_1
AS
BEGIN
	ALTER TABLE Flight
	Alter COLUMN LengthOfFlight smallint
	PRINT 'Changed the type of LengthOfFlight to smallint'
END
GO
EXEC upto_1