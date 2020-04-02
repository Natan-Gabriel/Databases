CREATE PROCEDURE upto_9
AS
BEGIN
	ALTER TABLE lounge
	DROP CONSTRAINT df_4
	print 'Drop default constraint'
END
GO
EXEC upto_9
