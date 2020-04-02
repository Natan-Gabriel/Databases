CREATE PROCEDURE upto_10
AS
BEGIN
	ALTER TABLE lounge
	DROP constraint pk_2
	PRINT 'Dropped PK for lounge'
END

GO

EXEC upto_10

