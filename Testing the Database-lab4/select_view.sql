create PROCEDURE select_view
	@name varchar(30)
AS
BEGIN
	-- SET NOCOUNT ON
	SET NOCOUNT ON;

	if @name = 'view_1'
	begin
		select * from view_1
	end

	if @name = 'view_2'
	begin
		select * from view_2
	end

	if @name = 'view_3'
	begin
		select * from view_3
	end
END