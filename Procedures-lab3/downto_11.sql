CREATE PROCEDURE downto_11
AS
BEGIN
	ALTER TABLE lounge
	ADD constraint fk_3 FOREIGN KEY(AId) REFERENCES Aircraft(AId)
	Print 'Add foreign key'

END
GO
EXEC downto_11
