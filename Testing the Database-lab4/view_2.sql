create view view_2 as
select A.AId,A.AircraftName --select aircrafts that flies to respected hubs
from Aircraft A,Hub H
where H.Reputation>5 and H.HId=A.HId 
