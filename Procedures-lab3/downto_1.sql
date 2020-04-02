CREATE PROCEDURE downto_1
AS
BEGIN
	ALTER TABLE Hub
	DROP COLUMN rankingPlace
	PRINT 'Dropped the column rankingPlace from table Hub'
END
GO
EXEC downto_1

select* from Hub