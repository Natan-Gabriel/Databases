/*CREATE PROCEDURE main2
	-- Add the parameters for the stored procedure here
	@nr_rows1 varchar(30),
	@nr_rows2 varchar(30),
	@nr_rows3 varchar(30)
AS
BEGIN
	-- SET NOCOUNT ON
	SET NOCOUNT ON;

	if ISNUMERIC(@nr_rows1) != 1
	BEGIN
		print('nr_rows1 is not a number')
		return 1 
	END
	if ISNUMERIC(@nr_rows2) != 1
	BEGIN
		print('nr_rows2 is not a number')
		return 1 
	END
	if ISNUMERIC(@nr_rows3) != 1
	BEGIN
		print('nr_rows3 is not a number')
		return 1 
	END
	
	--SET @nr_rows = cast(@nr_rows as INT)

	declare @all_start datetime
	set @all_start = GETDATE();


	declare @isPiloted_delete_start datetime
	set @isPiloted_delete_start = GETDATE()
	execute delete_rows @nr_rows1, 'isPiloted'
	declare @isPiloted_delete_end datetime
	set @isPiloted_delete_end = GETDATE()

	declare @Aircraft_delete_start datetime
	set @Aircraft_delete_start = GETDATE()
	execute delete_rows @nr_rows2, 'Aircraft'
	declare @Aircraft_delete_end datetime
	set @Aircraft_delete_end = GETDATE()

	declare @Hub_delete_start datetime
	set @Hub_delete_start = GETDATE()
	execute delete_rows @nr_rows3, 'Hub'
	declare @Hub_delete_end datetime
	set @Hub_delete_end = GETDATE()


	declare @Hub_insert_start datetime
	set @Hub_insert_start = GETDATE()
	execute insert_rows @nr_rows3, 'Hub'
	declare @Hub_insert_end datetime
	set @Hub_insert_end = GETDATE()

	declare @Aircraft_insert_start datetime
	set @Aircraft_insert_start = GETDATE()
	execute insert_rows @nr_rows2, 'Aircraft'
	declare @Aircraft_insert_end datetime
	set @Aircraft_insert_end = GETDATE()

	declare @isPiloted_insert_start datetime
	set @isPiloted_insert_start = GETDATE()
	execute insert_rows @nr_rows1, 'isPiloted'
	declare @isPiloted_insert_end datetime
	set @isPiloted_insert_end = GETDATE()



	declare @view_1_start datetime
	set @view_1_start = GETDATE()
	execute select_view 'view_1'
	declare @view_1_end datetime
	set @view_1_end = GETDATE()

	declare @view_2_start datetime
	set @view_2_start = GETDATE()
	execute select_view 'view_2'
	declare @view_2_end datetime
	set @view_2_end = GETDATE()

	declare @view_3_start datetime
	set @view_3_start = GETDATE()
	execute select_view 'view_3'
	declare @view_3_end datetime
	set @view_3_end = GETDATE()

	declare @all_stop datetime 
	set @all_stop = getdate() 

	declare @description varchar(100)
	set @description = 'TestRun: delete, insert, select all views'

	insert into TestRuns(Description, StartAt, EndAt)
	values(@description, @all_start, @all_stop);

	declare @lastTestRunID int; 
	set @lastTestRunID = (select max(TestRunID) from TestRuns);

	insert into TestRunTables
	values(@lastTestRunID, 1, @Hub_delete_start, @Hub_insert_end)

	insert into TestRunTables
	values(@lastTestRunID, 2, @Aircraft_delete_start, @Aircraft_insert_end)

	insert into TestRunTables
	values(@lastTestRunID, 3, @isPiloted_delete_start, @isPiloted_insert_end)

	insert into TestRunViews
	values(@lastTestRunID, 1, @view_1_start, @view_1_end)
	
	insert into TestRunViews
	values(@lastTestRunID, 2, @view_2_start, @view_2_end)

	insert into TestRunViews
	values(@lastTestRunID,3, @view_3_start, @view_3_end)



END

exec main2 1000 ,1000, 1000


select * from TestRunTables
select * from TestRunViews


	execute insert_rows 100, 'Hub'

	execute insert_rows 100, 'Aircraft'

	execute insert_rows 100, 'isPiloted'
	select * from Aircraft
	delete from  isPiloted
		delete from Aircraft
			delete from  Hub*/


CREATE PROCEDURE main2
AS
BEGIN
	-- SET NOCOUNT ON
	SET NOCOUNT ON;

	declare @all_start datetime
	set @all_start = GETDATE();

	declare @curr int
	set @curr=1
	declare @x int =(select NoOfRows from TestTables where Position=@curr)

	set @curr=@curr+1

	declare @isPiloted_delete_start datetime
	set @isPiloted_delete_start = GETDATE()
	execute delete_rows @x, 'isPiloted'
	declare @isPiloted_delete_end datetime
	set @isPiloted_delete_end = GETDATE()

	set @x =(select NoOfRows from TestTables where Position=@curr)
    set @curr=@curr+1

	declare @Aircraft_delete_start datetime
	set @Aircraft_delete_start = GETDATE()
	execute delete_rows @x, 'Aircraft'
	declare @Aircraft_delete_end datetime
	set @Aircraft_delete_end = GETDATE()

	set @x =(select NoOfRows from TestTables where Position=@curr)
    set @curr=@curr+1

	declare @Hub_delete_start datetime
	set @Hub_delete_start = GETDATE()
	execute delete_rows @x, 'Hub'
	declare @Hub_delete_end datetime
	set @Hub_delete_end = GETDATE()

	set @x =(select NoOfRows from TestTables where Position=@curr)
    set @curr=@curr+1

	declare @Hub_insert_start datetime
	set @Hub_insert_start = GETDATE()
	execute insert_rows @x, 'Hub'
	declare @Hub_insert_end datetime
	set @Hub_insert_end = GETDATE()

	set @x =(select NoOfRows from TestTables where Position=@curr)
    set @curr=@curr+1

	declare @Aircraft_insert_start datetime
	set @Aircraft_insert_start = GETDATE()
	execute insert_rows @x, 'Aircraft'
	declare @Aircraft_insert_end datetime
	set @Aircraft_insert_end = GETDATE()

	set @x =(select NoOfRows from TestTables where Position=@curr)
    set @curr=@curr+1

	declare @isPiloted_insert_start datetime
	set @isPiloted_insert_start = GETDATE()
	execute insert_rows @x, 'isPiloted'
	declare @isPiloted_insert_end datetime
	set @isPiloted_insert_end = GETDATE()



	declare @view_1_start datetime
	set @view_1_start = GETDATE()
	execute select_view 'view_1'
	declare @view_1_end datetime
	set @view_1_end = GETDATE()


	declare @view_2_start datetime
	set @view_2_start = GETDATE()
	execute select_view 'view_2'
	declare @view_2_end datetime
	set @view_2_end = GETDATE()

	declare @view_3_start datetime
	set @view_3_start = GETDATE()
	execute select_view 'view_3'
	declare @view_3_end datetime
	set @view_3_end = GETDATE()

	declare @all_stop datetime 
	set @all_stop = getdate() 

	declare @description varchar(100)
	set @description = 'TestRun: delete, insert, select all views'

	insert into TestRuns(Description, StartAt, EndAt)
	values(@description, @all_start, @all_stop);

	declare @lastTestRunID int; 
	set @lastTestRunID = (select max(TestRunID) from TestRuns);

	insert into TestRunTables
	values(@lastTestRunID, 1, @Hub_delete_start, @Hub_insert_end)

	insert into TestRunTables
	values(@lastTestRunID, 2, @Aircraft_delete_start, @Aircraft_insert_end)

	insert into TestRunTables
	values(@lastTestRunID, 3, @isPiloted_delete_start, @isPiloted_insert_end)

	insert into TestRunViews
	values(@lastTestRunID, 1, @view_1_start, @view_1_end)
	
	insert into TestRunViews
	values(@lastTestRunID, 2, @view_2_start, @view_2_end)

	insert into TestRunViews
	values(@lastTestRunID,3, @view_3_start, @view_3_end)



END

exec main2 

select * from TestRuns
select * from TestRunTables
select * from TestRunViews
--delete from TestRunTables
--delete from TestRunViews
/*delete from  isPiloted
delete from Aircraft
delete from  Hub

execute insert_rows 800, 'Hub'

execute insert_rows 1100, 'Aircraft'

execute insert_rows 1000, 'isPiloted'
select * from Aircraft
*/
