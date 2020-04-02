CREATE PROCEDURE downto_9
AS
BEGIN
	ALTER TABLE lounge
	ADD CONSTRAINT pk_2 PRIMARY KEY(id)
	PRINT 'Added PK for lounge'
END

GO

EXEC downto_9
