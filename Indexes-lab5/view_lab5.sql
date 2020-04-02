create view view1 as
select *
from (SELECT A.AId,A.TailNumber,I.PId
		FROM Aircraft A
		FUll JOIN isPiloted I ON I.AId =
		A.AId ) as p
--where H.Reputation>5 and H.HId=A.HId 
--group by A.AircraftName
   

--select  * from view1
