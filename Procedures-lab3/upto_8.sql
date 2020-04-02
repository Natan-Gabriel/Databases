CREATE PROCEDURE upto_8
AS
BEGIN
	ALTER TABLE Manager
	DROP COLUMN Seniority
	PRINT 'Dropped the column Seniority'
END
GO
EXEC upto_8
