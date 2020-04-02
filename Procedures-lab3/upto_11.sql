CREATE PROCEDURE upto_11
AS
BEGIN
	ALTER TABLE lounge
	drop CONSTRAINT c_1
	PRINT 'Remove candidate key'
END
GO
EXEC upto_11
