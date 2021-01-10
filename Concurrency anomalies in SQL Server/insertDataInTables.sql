create or alter proc spInsertDataAllInOneTransaction
	@AircraftRegistration varchar(100),
	@AircraftType varchar(100),
	@PilotName varchar(100),
	@PilotReputation int,
	@PilotedHours int

	as
	begin tran
		begin try
		
			if @AircraftRegistration is null or @AircraftType is null
			begin
				raiserror('AircraftRegistration or AircraftType is invalid',16,1)
				return 1
			end

			if @PilotName is null or @PilotReputation is null
			begin
				raiserror('PilotName or PilotReputation is invalid',16,1)
				return 1
			end

			if @PilotedHours is null or @PilotedHours<0 
			begin
				raiserror('PilotedHours should not be null and should not be less than 0',16,1)
				return 1
			end

			if exists (select * from Aircraft A where A.AircraftRegistration=@AircraftRegistration)
				update Aircraft set AircraftType=@AircraftType where AircraftRegistration=@AircraftRegistration
			else
				insert Aircraft values (@AircraftRegistration,@AircraftType) 

			if exists (select PId from Pilot P where P.PilotName=@PilotName)
				update Pilot set PilotReputation=@PilotReputation where PilotName=@PilotName
			else
				insert Pilot values (@PilotName,@PilotReputation) 

			declare @AId int =(select AId from Aircraft A
								where A.AircraftRegistration=@AircraftRegistration )
			declare @PId int =(select PId from Pilot P
								where P.PilotName=@pilotName )
			if @AId is null or @PId is null
			begin
				raiserror('no such aircraft or pilot',16,1)
				return 1
			end

			if exists (select * from isPiloted isP
						where isP.AId= @AId and isP.PId=@PId)
					update isPiloted
					set PilotedHours=@PilotedHours
					where AId=@AId and PId=@PId
			else
					insert isPiloted values (@AId,@PId,@PilotedHours) 
			commit tran
			insert Logger values('all operations in spInsertDataAllInOneTransaction were successfully executed')
		end try
		begin catch
			rollback tran
			print ERROR_MESSAGE()
			print 'Rolledback all transactions in spInsertDataAllInOneTransaction'
			insert Logger values(ERROR_MESSAGE())
			insert Logger values('Rolledback all transactions in spInsertDataAllInOneTransaction')
		end catch
go
create or alter proc spInsertDataInDifferentTransactions
	@AircraftRegistration varchar(100),
	@AircraftType varchar(100),
	@PilotName varchar(100),
	@PilotReputation int,
	@PilotedHours int

	as
	begin try
		declare @res int
		execute @res=spAddAircraft @AircraftRegistration,@AircraftType
		if @res=1
		begin
				raiserror('addAircraft failed',16,1)
				return 1
		end
		execute @res=spAddPilot @PilotName,@PilotReputation
		if @res=1
		begin
				raiserror('addPilot failed',16,1)
				return 1
		end
		execute @res=spAddisPiloted @AircraftRegistration,@PilotName,@PilotedHours
		if @res=1
		begin
				raiserror('addisPiloted failed',16,1)
				return 1
		end
		insert Logger values('all operations in spInsertDataInDifferentTransactions were successfully executed')
	end try
	begin catch
		print ERROR_MESSAGE()
		print 'all successful operations were  preserved'
		insert Logger values(ERROR_MESSAGE())
		insert Logger values('all successful operations before the failed one were  preserved')
	end catch
go

/*spInsertDataAllInOneTransaction
spInsertDataInDifferentTransactions*/
delete from Logger
delete from isPiloted
delete from Aircraft
delete from Pilot
/*execute spAddAircraft 'NFTTYU','Boeing 737'
execute spAddPilot 'Richard Thomson',10
execute spAddisPiloted 'NFTTYU','Richard Thomson',0
execute spAddisPiloted 'NFTTYU','Richard Thomso',5*/
/*execute spInsertDataAllInOneTransaction 'NFTTYU','Boeing 737','Richard Thomson',10,-2*/


execute spInsertDataAllInOneTransaction 'NFTTYU','Boeing 737','Richard Thomson',10,-2

select * from Aircraft
select * from Pilot
select * from isPiloted

execute spInsertDataAllInOneTransaction 'NFTTYU','Boeing 737','Richard Thomson',10,0

select * from Aircraft
select * from Pilot
select * from isPiloted

execute spInsertDataInDifferentTransactions 'HJERBY','Airbus a320','George Andrei',10,-2

select * from Aircraft
select * from Pilot
select * from isPiloted

execute spInsertDataInDifferentTransactions 'HJERBY','Airbus a320','George Andrei',10,0

select * from Aircraft
select * from Pilot
select * from isPiloted

select * from Logger

