CREATE PROCEDURE upto_2
AS
BEGIN
	ALTER TABLE Hub
	ADD rankingPlace INT
	PRINT 'Added the column rankingPlace in table Hub'
END
GO
EXEC upto_2

select* from Hub