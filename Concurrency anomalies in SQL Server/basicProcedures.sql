use lab3DBMSv3
go

create or alter proc spAddAircraft
	@AircraftRegistration varchar(100),
	@AircraftType varchar(100)
	as

	begin tran
		begin try
			if @AircraftRegistration is null or @AircraftType is null
			begin
				raiserror('AircraftRegistration or AircraftType is invalid',16,1)
				return 1
			end

			
			if exists (select AId from Aircraft A where A.AircraftRegistration=@AircraftRegistration )
				update Aircraft set AircraftType=@AircraftType where AircraftRegistration=@AircraftRegistration
			else
				insert Aircraft values (@AircraftRegistration,@AircraftType) 

			commit tran
		end try
		begin catch
			rollback tran
			print 'Rolledback transaction in spAddAircraft'
			print ERROR_MESSAGE()
			return 1
		end catch
	return 0
	
go

create or alter proc spAddPilot
	@PilotName varchar(100),
	@PilotReputation int
	as

	begin tran
		begin try
			if @PilotName is null or @PilotReputation is null
			begin
				raiserror('PilotName or PilotReputation is invalid',16,1)
				return 1
			end

			if exists (select * from Pilot PT where PT.PilotName=@PilotName )
				update Pilot set PilotReputation=@PilotReputation where PilotName=@PilotName
			else
				insert Pilot values (@PilotName,@PilotReputation) 
			commit tran
		end try
		begin catch
			rollback tran
			print 'Rolledback transaction in spAddPilot'
			print ERROR_MESSAGE()
			return 1
		end catch
	return 0
go

create or alter proc spAddisPiloted
	@AircraftRegistration varchar(100),
	@PilotName varchar(100),
	@PilotedHours int

	as
	begin tran
		begin try
			declare @AId int =(select AId from Aircraft A
								where A.AircraftRegistration=@AircraftRegistration )
			declare @PId int =(select PId from Pilot P
								where P.PilotName=@pilotName )
			if @PilotedHours is null or @PilotedHours<0 
			begin
				raiserror('PilotedHours should not be null or less than 0',16,1)
				return 1
			end
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
		end try
		begin catch
			rollback tran
			print 'Rolledback transaction in spAddisPiloted'
			print ERROR_MESSAGE()
			return 1
		end catch
	return 0
go

delete from isPiloted
delete from Aircraft
delete from Pilot
execute spAddAircraft 'NFTTYU','Boeing 737'
execute spAddPilot 'Richard Thomson',10
execute spAddisPiloted 'NFTTYU','Richard Thomson',0
execute spAddisPiloted 'NFTTYU','Richard Thomso',5

select * from Aircraft
select * from Pilot
select * from isPiloted

go

