CREATE PROCEDURE downto_10
AS
BEGIN
	ALTER TABLE lounge
	ADD CONSTRAINT c_1 UNIQUE(Code);
	PRINT 'Add candidate key'
END
GO
EXEC downto_10
