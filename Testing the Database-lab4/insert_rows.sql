Create PROCEDURE insert_rows
	@nr_rows varchar(30),
	@name varchar(30)
AS
BEGIN
	--prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @table varchar (100)
	set @table = ('[' + @name + ']')

	if @name = 'Hub' or @name = 'Aircraft' 
	begin
		DBCC CHECKIDENT (@table, RESEED, 0);
	end

	if ISNUMERIC(@nr_rows) != 1
	BEGIN
		print('nr_rows is not a number')
		return 1 
	END
	
	SET @nr_rows = cast(@nr_rows as INT)

	declare @contor int
	set @contor = 1

	declare @HubName varchar(100)
	declare @HubCode varchar(5)
	declare @Price int
	declare @Reputation int
	
	declare @AircraftName varchar(100)
	declare @HId int

	declare @PilotedHours int
	declare @PId int
	declare @AId int



	while @contor <= @nr_rows
	begin
		if @name = 'Hub'
		begin
			set @HubName = 'Hub' + convert(varchar(7), (@contor+1000))
			set @HubCode = 'LH' + convert(varchar(1), (@contor%10))
			set @Price = @contor
			set @Reputation = (@contor+10)
			insert into Hub values (@HubName,@HubCode,@Price,@Reputation)
		end
		
		if @name = 'Aircraft'
		begin
			set @HId = (select max(HId) from Hub) - @contor + 1
			set @AircraftName='Airbus a380-'+ convert(varchar(1), (@contor%10))
			insert into Aircraft values (@AircraftName,@HId)
		end
		if @name = 'isPiloted'
		begin
			set @AId = (select max(AId) from Aircraft) - @contor + 1
			set @PId = (select max(PId) from Pilot)
			set @PilotedHours =  @contor
			insert into isPiloted values (@AId, @PId, @PilotedHours) 
		end

		set @contor = @contor + 1
	end
	
END