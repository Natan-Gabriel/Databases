Create PROCEDURE Pr5 @v Int

AS
BEGIN
  
	DECLARE @nextStep varchar(30)
	DECLARE @currentVersion INT
	SET @currentVersion = (SELECT id_version FROM Version)
	
	if @v < 0 or @v > 13
	BEGIN
		print('Invalid number')
		return 2 
	END

	while @currentVersion < @v
	begin
		SET @currentVersion = @currentVersion + 1
		SET @nextStep = 'upto_' + convert(varchar(3), @currentVersion)
		execute @nextStep
	end

	while @currentVersion > @v
	begin
		SET @currentVersion = @currentVersion - 1
		SET @nextStep = 'downto_' + convert(varchar(3), @currentVersion)
		execute @nextStep
	end

	truncate table Version
	insert into Version values(@v)
END
go

truncate table Version
insert into Version values(0)

select * from Version


exec Pr5 13
exec Pr5 0

/*
exec downto_6

exec Pr5 5
select * from Manager


exec downto_1
exec downto_2
exec downto_3
exec downto_4
exec downto_5
exec downto_6
exec downto_7
 */



