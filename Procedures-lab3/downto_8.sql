CREATE PROCEDURE downto_8
AS
BEGIN
	ALTER TABLE lounge
	ADD CONSTRAINT df_4 DEFAULT 3  FOR Reputation
	print 'Add default constraint'
END
GO
EXEC downto_8