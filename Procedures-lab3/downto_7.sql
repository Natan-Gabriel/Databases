CREATE PROCEDURE downto_7
AS
BEGIN
	ALTER TABLE Manager
	ADD Seniority int
	PRINT 'Added the column Seniority'
END
GO
EXEC downto_7

select* from Hub