CREATE TABLE Aircraft
(AId INT PRIMARY KEY IDENTITY,
TailNumber int UNIQUE,
NoOfSeats int
)
--drop table Aircraft

CREATE TABLE Pilot
(PId INT PRIMARY KEY IDENTITY,
PilotReputation int,
PilotSlary int
)
--drop table Pilot
CREATE TABLE isPiloted
(
IId INT PRIMARY KEY IDENTITY,
AId INT FOREIGN KEY REFERENCES Aircraft(AId),
PId INT FOREIGN KEY REFERENCES Pilot(PId)
)

--drop table isPiloted
insert into Pilot values (10)
select * from Pilot
select * from isPiloted
select * from Aircraft


DBCC CHECKIDENT ('Aircraft', RESEED, 0);
DBCC CHECKIDENT ('Pilot', RESEED, 0);
DBCC CHECKIDENT ('isPiloted', RESEED, 0);

declare @index int
set @index=1

declare @nr int
set @nr=2000

while @index<@nr
	begin
		insert into Aircraft values(@index,@index)
		set @index=@index+1

	end



select * from Pilot

declare @index1 int
set @index1=1
declare @nr1 int
set @nr1=200000

while @index1<=@nr1
	begin
		insert into Pilot values(@index1%10,@index1)
		set @index1=@index1+1

	end

--delete from Pilot


select * from isPiloted
--delete from isPiloted

declare @index2 int
set @index2=1
declare @nr2 int
--set @nr2=2000

while @index2<=@nr2
	begin
		insert into isPiloted values (@index2% (select max(AId) from Aircraft) +1, @index2%(select max(PId) from Pilot) +1 ) 
		set @index2=@index2+1

	end
