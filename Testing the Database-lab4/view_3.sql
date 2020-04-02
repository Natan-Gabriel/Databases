create view view3 as
select *
from (SELECT P.PId,I.AId
		FROM Pilot P
		FUll JOIN isPiloted I ON P.PId =
		I.AId ) as p

--select  * from view3

