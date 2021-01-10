--dirty reads is allowed only in read uncommited isolation level
go
create or alter proc spDirtyRead1
as
begin tran 
update Hub set HubName='CDG'
WAITFOR DELAY '00:00:04';
rollback tran

go

create or alter proc spDirtyRead2
as
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
begin tran 
WAITFOR DELAY '00:00:01';
select * from Hub;---read uncomitted data
WAITFOR DELAY '00:00:03';
select * from Hub;--read data after rollback
commit tran
go

create or alter proc spDirtyRead3
as
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
begin tran 
WAITFOR DELAY '00:00:01';
select * from Hub;
WAITFOR DELAY '00:00:03';
select * from Hub;
commit tran
go
--select * from Hub
--delete from Hub
exec spDirtyRead1
--exec spDirtyRead2
------------------------------------------------------------------------------------------------------------

go
create or alter proc spUnrepeatableReadsv1
as
--WAITFOR DELAY '00:00:01';
begin tran 
WAITFOR DELAY '00:00:01';
update Hub set HubName='CDG'
--WAITFOR DELAY '00:00:04';
commit tran

go

create or alter proc spUnrepeatableReadsv2
as
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
begin tran 
select * from Hub;
WAITFOR DELAY '00:00:03';
select * from Hub;
commit tran
go

exec spUnrepeatableReadsv2
-----------------------------------------------------------------------------------------------------------------
update Hub set HubName='LHR'--at the beginning of both execute this
select * from Hub
go
create or alter proc spUnrepeatableReads1
as
--WAITFOR DELAY '00:00:01';
begin tran 
WAITFOR DELAY '00:00:01';
update Hub set HubName='CDG'
--WAITFOR DELAY '00:00:04';
commit tran

go


create or alter proc spUnrepeatableReads2
as
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
begin tran 
select * from Hub;--reads data from start
WAITFOR DELAY '00:00:02';
select * from Hub;--reads data commited by spUnrepeatableReads1
commit tran
go

create or alter proc spUnrepeatableReads3
as
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
begin tran 
select * from Hub;
WAITFOR DELAY '00:00:02';
select * from Hub;
commit tran
go


exec spUnrepeatableReads2
exec spUnrepeatableReads3
--------------------------------------------------------------------------------------------------------------------------
--delete from Hub--execute this at the biginning
go
create or alter proc spPhantoms1
as
--WAITFOR DELAY '00:00:01';
begin tran 
WAITFOR DELAY '00:00:01';
--update Hub set HubName='CDG'
insert Hub values ('MLA')
--WAITFOR DELAY '00:00:04';
commit tran

go


create or alter proc spPhantoms2
as
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
begin tran 
select * from Hub;
WAITFOR DELAY '00:00:02';
select * from Hub;
commit tran
go

exec spPhantoms2
go 

create or alter proc spPhantoms3
as
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
begin tran 
select * from Hub;
WAITFOR DELAY '00:00:03';
select * from Hub;
commit tran
go

exec spPhantoms3
select * from Hub
----------------------------------------------------------------------------------------------------------------------

go
create or alter proc spDeadlock1
as
--SET DEADLOCK_PRIORITY -10
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
begin tran 
update Hub set HubName='C14'
WAITFOR DELAY '00:00:03';
--select * from Gate
update GATE set GateName='G104'
commit tran

go


create or alter proc spDeadlock2
as

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
begin tran 
--insert GATE values ('1')
update GATE set GateName='G102'
--update Hub set HubName='C15'
WAITFOR DELAY '00:00:03';
--select * from Hub
update Hub set HubName='C12'
--update GATE set GateName='G105'
commit tran
go


create or alter proc spDeadlock3
as

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
begin tran 
update Hub set HubName='C15'
WAITFOR DELAY '00:00:03';
update GATE set GateName='G105'
commit tran
go



exec spDeadlock1

select * from GATE
select * from HUB
------------------------------------------------------------------------------------------------------------------------

--update conflict && optimistic =>row-level versioning
ALTER DATABASE lab3DBMSv3
SET ALLOW_SNAPSHOT_ISOLATION ON

go
create or alter proc spRowVer1
as
--SET DEADLOCK_PRIORITY -10
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
begin tran 
--update Hub set HubName='C14'
WAITFOR DELAY '00:00:03';
--select * from Gate
update GATE set GateName='G104'
commit tran

go



create or alter proc spRowVer2
as

SET TRANSACTION ISOLATION LEVEL SNAPSHOT
begin tran 
--insert GATE values ('1')
update GATE set GateName='G102'
--update Hub set HubName='C15'
WAITFOR DELAY '00:00:03';
--select * from Hub
--update Hub set HubName='C12'
--update GATE set GateName='G105'
commit tran
go

execute spRowVer1