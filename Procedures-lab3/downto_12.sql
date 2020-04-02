CREATE PROCEDURE downto_12
AS
BEGIN
	CREATE TABLE Manager
(MId INT PRIMARY KEY IDENTITY,
ManagerName varchar(100) NOT NULL,
ManagerReputation int,
 SId INT FOREIGN KEY REFERENCES Salary(SId)
)
	PRINT 'Create Manager table'

END
GO
EXEC downto_12
