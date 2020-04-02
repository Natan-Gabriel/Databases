/*CREATE CLUSTERED INDEX IDX_CL_AId
   ON Aircraft(AId);*/

select * from Aircraft
where TailNumber>1990

select * from Aircraft
where AId>1000--clustered index seek

select * from Aircraft
where AId>500--clustered index seek

select * 
from Aircraft
WITH ( INDEX(PK__Aircraft__C6900628AEFEC981))--clustered index scan

select A.AId from Aircraft A--nonclusrtered index scan

select A.TailNumber from Aircraft A
where TailNumber>1000--nonclustered index seek

select A.NoOfSeats
from Aircraft A
WITH ( INDEX(UQ__Aircraft__3F41D11B0BBED8FB))--key lookup


--b)
select P.PilotReputation from Pilot P
Where P.PilotReputation=0

CREATE NONCLUSTERED INDEX IDX_NCL_Rep
   ON Pilot(PilotReputation);

select P.PilotReputation from Pilot P
Where P.PilotReputation=0

DROP INDEX Pilot.IDX_NCL_Rep;




--c)

select  * from view1

CREATE NONCLUSTERED INDEX IDX_NCL_isP ON isPiloted(AId);

select  * from view1

DROP INDEX isPiloted.IDX_NCL_isP;
/*DROP INDEX isPiloted.PK__isPilote__C4972BACE76896B2;
DROP INDEX Aircraft.PK__Aircraft__C6900628AEFEC981;
DROP INDEX Aircraft.UQ__Aircraft__3F41D11B0BBED8FB;
DROP INDEX Pilot.PK__Pilot__C5775540E18330CA;
select  * from view3
CREATE CLUSTERED INDEX PK__Pilot__C5775540E18330CA
   ON Pilot(PId);
CREATE NONCLUSTERED INDEX UQ__Aircraft__3F41D11B0BBED8FB
   ON Aircraft(TailNumber);
CREATE CLUSTERED INDEX PK__Aircraft__C6900628AEFEC981
   ON Aircraft(AId);
CREATE CLUSTERED INDEX PK__isPilote__C4972BACE76896B2
   ON isPiloted(IId);*/