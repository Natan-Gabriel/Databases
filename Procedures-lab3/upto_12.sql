CREATE PROCEDURE upto_12
AS
BEGIN
	ALTER TABLE lounge
	DROP CONSTRAINT fk_3
	Print 'Remove foreign key'

END
GO
EXEC upto_12

