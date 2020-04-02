Create PROCEDURE delete_rows
	@nr_rows varchar(30),
	@name varchar(30)
AS
BEGIN
	-- SET NOCOUNT ON
	SET NOCOUNT ON;

	if ISNUMERIC(@nr_rows) != 1
	BEGIN
		print('nr_rows is not a number')
		return 1 
	END
	
	SET @nr_rows = cast(@nr_rows as INT)

	declare @last_row int
	if @name = 'Hub'
		begin
			set @last_row = (select MAX(HId) from Hub) - @nr_rows

			delete from Hub
			where HId > @last_row
		end
		
	if @name = 'Aircraft'
		begin
			set @last_row =(select MAX(AId) from Aircraft) - @nr_rows
			delete from Aircraft
			where AId > @last_row
		end

	if @name = 'isPiloted'
		begin
			delete from isPiloted
		end
END