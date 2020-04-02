CREATE PROCEDURE upto_7
AS
BEGIN
	Create TABLE NewOne(Name varchar(100) NOT NULL)
	PRINT 'Create new table'

END
Go
EXEC upto_7

select* from NewOne