USE [lab2]

DELETE FROM Flight WHERE 1=1;
DELETE FROM Timetable WHERE 1=1;
DELETE FROM isPiloted WHERE 1=1;
DELETE FROM Aircraft WHERE 1=1;
DELETE FROM Hub WHERE 1=1;
DELETE FROM Pilot WHERE 1=1;
DELETE FROM Salary WHERE 1=1;
DELETE FROM Cities WHERE 1=1;

DBCC CHECKIDENT('Hub',RESEED,0)
DBCC CHECKIDENT('Aircraft',RESEED,0)
DBCC CHECKIDENT('Flight',RESEED,0)
DBCC CHECKIDENT('Salary',RESEED,0)
DBCC CHECKIDENT('Pilot',RESEED,0)
DBCC CHECKIDENT('Cities',RESEED,0)

INSERT INTO Hub VALUES ('Heathrow','LHR',1000,12)
INSERT INTO Hub VALUES ('Charles De Gaulle','CDG',800, 13)
INSERT INTO Hub VALUES ('Schipol','AMS', 1100,15)
INSERT INTO Hub VALUES ('Ataturk','LST',700,9)
INSERT INTO Hub VALUES ('Frankfurt','FRA', 500,15)
INSERT INTO Hub VALUES ('Malta','MLA',2000, 9)
INSERT INTO Hub VALUES ('Bologna','BLQ',1500, 12)
INSERT INTO Hub VALUES ('Avram Iancu',NULL,100, 0)
INSERT INTO Hub VALUES (NULL,NULL,0, 0)

INSERT INTO Aircraft VALUES ('Airbus a318', 1)
INSERT INTO Aircraft VALUES ('Airbus a380', 1)
INSERT INTO Aircraft VALUES ('Boeing 767-200', 2)
INSERT INTO Aircraft VALUES ('Airbus a320', 6)
INSERT INTO Aircraft VALUES ('Boeing 737-700', 8)
INSERT INTO Aircraft VALUES ('Airbus a380', 2)

INSERT INTO Timetable VALUES (1, 'Apq-100')
INSERT INTO Timetable VALUES (2,'Rwe-150')
INSERT INTO Timetable VALUES (3,'R-50')
--INSERT INTO Timetable VALUES (2,'Rwe-150')

INSERT INTO Cities VALUES ('Roma')
INSERT INTO Cities VALUES ('Viena')

INSERT INTO Flight VALUES ('DL0047',8,'UY',3,1) --these flights are operated today
INSERT INTO Flight VALUES ('BA0751',1,'HB',1,1)
INSERT INTO Flight VALUES ('FY9080',7,'UU',5,1)
INSERT INTO Flight VALUES ('DL0047',7,'PO',1,1)
INSERT INTO Flight VALUES ('FY9080',6,'KU',5,1)
INSERT INTO Flight VALUES ('AF0065',8,'LA',4,1)

INSERT INTO Salary VALUES ('100')
INSERT INTO Salary VALUES ('100')

INSERT INTO Pilot VALUES ('Guillherme',10,10,1)
INSERT INTO Pilot VALUES ('Andrew',7,7,2)

INSERT INTO isPiloted VALUES (1,1,100)
INSERT INTO isPiloted VALUES (1,2,300)
INSERT INTO isPiloted VALUES (2,1,100)
INSERT INTO isPiloted VALUES (2,2,300)





UPDATE Flight
SET LengthOfFlight = LengthOfFlight + 1-- to avoid fines
WHERE LengthOfFlight>6

UPDATE Hub
SET Reputation = Reputation + 1
WHERE Reputation>12 --get extra point for good reputation

UPDATE Hub
SET Price = Price*0.2
WHERE Reputation>12--increase priec

DELETE FROM Hub
WHERE HubCode is NULL and HubName is NULL --we need Hub code for each hub

DELETE FROM Timetable
WHERE TimetableName='R-50'

SELECT * FROM Hub

SELECT * FROM Aircraft

SELECT * FROM Flight

SELECT * FROM Timetable

SELECT * FROM Pilot

SELECT * FROM isPiloted

--a)
SELECT H.HubName
FROM Hub H
WHERE H.HubCode = 'LHR' OR H.Reputation>13 --select all airport with great reputation and the principal airport

SELECT H.HId
FROM Hub H
WHERE H.Reputation > 7
UNION
SELECT A.HId
FROM Aircraft A --select active airport or possible active

--b)
SELECT H.HId
FROM Hub H
WHERE H.Reputation >=14
INTERSECT
SELECT A.HId
FROM Aircraft A  --reserve slots for active airport which also have great reputation


SELECT DISTINCT A.AircraftName
FROM Aircraft A
WHERE A.HId IN (SELECT H.HId
FROM Hub H
WHERE H.HubCode is NULL) --select the aircrafts which should arive at wrong destionation

--c)

SELECT A.AircraftName
FROM Aircraft A
WHERE A.AId NOT IN (SELECT F.AId
FROM Flight F) --select the aircrafts who don't fly today

SELECT A.AircraftName
FROM Aircraft A,Hub H
WHERE A.HId=H.HId and H.Reputation>12
EXCEPT
SELECT A.AircraftName
FROM Aircraft A,Flight F
WHERE A.AId=F.AId --select aircraft which fly to airports with great reputations,but not fly today 

--d)
-- hub-flight inner join

SELECT H.HubName, F.FlightNumber
FROM Hub H
INNER JOIN Aircraft A ON H.HId =
A.HId
INNER JOIN Flight F ON A.AId
= F.AId     

SELECT A.AircraftName, F.RouteOfFlight
FROM Aircraft A
LEFT JOIN Flight F ON
A.AId = F.AId

SELECT A.AircraftName,H.HubName
FROM Aircraft A
Right JOIN Hub H ON
H.HId = A.HId

SELECT p1.CId,p2.PId
FROM(SELECT A.AId, C.CId
	FROM Aircraft A
	FULL JOIN Flight F ON A.AId =
	F.AId
	FULL JOIN Cities C ON F.CId 
	=C.CId) as p1
FULL JOIN 
	(SELECT P.PId, A.AId
	FROM Pilot P
	FULL JOIN isPiloted I ON P.PId =
	I.PId
	FULL JOIN Aircraft A ON I.AId 
	=A.AId)as p2
	on p2.AId=p1.AId


SELECT P.PId, A.AId
FROM Pilot P
FULL JOIN isPiloted I ON P.PId =
I.PId
FULL JOIN Aircraft A ON I.AId 
=A.AId


--e)
SELECT DISTINCT F.FlightNumber
FROM Flight F
WHERE F.AId IN (SELECT A.AId
FROM Aircraft A
WHERE A.HId IN (SELECT H.HId
FROM Hub H
WHERE H.HubCode is NULL)) --select the flightNumber of flights which should arive at wrong destionation

SELECT A.AId
FROM Aircraft A
WHERE A.HId IN (SELECT H.HId
FROM Hub H
WHERE H.HubCode is NULL) --select the aircrafts which should arive at wrong destionation

--f)
SELECT DISTINCT A.AircraftName
FROM Aircraft A
WHERE NOT EXISTS (SELECT * FROM
Flight F WHERE F.AId=A.AId) --select the aircrafts who don't fly today


--SELECT A.AircraftName
--FROM Aircraft A
--WHERE A.AId NOT IN (SELECT F.AId
--FROM Flight F) 
---
--SELECT A.AircraftName
--FROM Aircraft A
--WHERE A.HId IN (SELECT H.HId
--FROM Hub H
--WHERE H.HubCode is NULL) --select the aircrafts which should arive at wrong destionation


SELECT DISTINCT A.AircraftName
FROM Aircraft A
WHERE EXISTS (SELECT *
FROM Hub H
WHERE H.HubCode is NULL and H.HId=A.HId) --select the aircrafts which should arive at wrong destionation

--g)

SELECT DISTINCT P.AircraftName
FROM (SELECT A.AId,A.AircraftName,A.HId 
from Aircraft A) as P
WHERE P.AId NOT IN (SELECT F.AId
FROM Flight F) --select the aircrafts which don't fly today

SELECT P.HubName
FROM (SELECT H.HubName,H.Reputation
FROM Hub H) as P
WHERE P.Reputation>12 --select all airport wigh great reputation

--h)

--SELECT F.FId, COUNT(*) AS no_gr
--FROM Flight F
--GROUP BY F.FId

--SELECT A.AId, COUNT(*) AS no_gr,AVG(LengthOfFlight) AS gr_avg
--FROM Aircraft A,Flight F
--GROUP BY A.AId

SELECT F.FlightNumber
FROM Flight F
GROUP BY F.FlightNumber --select the most frequent flights
HAVING COUNT(*)>1


SELECT A.AircraftName
FROM Aircraft A
GROUP BY A.AircraftName --select the largest fleets
HAVING COUNT(*)>1

SELECT F.FlightNumber
FROM Flight F
WHERE F.LengthOfFlight<7
GROUP BY F.FlightNumber --from all route having at least 2 flights for that route,we select flight if there if a  flight under 7 hours
HAVING 1<(Select COUNT(*)
			from Flight as F2
			WHERE F.FlightNumber=F2.FlightNumber)


SELECT H.Reputation
FROM Hub H
WHERE H.HubCode like 'L__'
GROUP BY H.Reputation
HAVING 900>(Select MIN(Price)
			from Hub as H2
			WHERE H2.Reputation=H.Reputation)
--from all reputation levels having an minimum price of 900$ for that route,we select that level if the hubName is like 'L__'


--i) GRESIT


SELECT F.LengthOfFlight,F.FlightNumber
FROM Flight F
WHERE F.LengthOfFlight = ANY
(SELECT MAX(F2.LengthOfFlight)
 FROM Flight F2) --select longest flights

 --SELECT F.LengthOfFlight,F.FlightNumber
--FROM Flight F
--WHERE F.LengthOfFlight >
--(SELECT F2.LengthOfFlight 
-- FROM Flight F2) --select longest flights

SELECT H.Reputation, H.HubName
FROM Hub H
WHERE H.Price < ANY
(SELECT MAX(H2.Price)
 FROM Hub H2)--select the reputation and hubname for not most expensive hubs

SELECT F.FlightNumber
FROM Flight F
WHERE F.AId != ALL
(SELECT A.AId
FROM Aircraft A
WHERE A.HId IN (SELECT H.HId
FROM Hub H
WHERE H.HubCode is NULL)) --aircrafts which should arrive at wrong destination--get all flights which CANNOT arrive at wring destination

SELECT H.HubName
FROM Hub H
WHERE H.HId != All
(SELECT A.HId
FROM Aircraft A
WHERE A.AId  IN (SELECT F.AId
FROM Flight F)) --select the aircrafts who fly today--select free HUBS

--RESCRIERE i) CORECT

SELECT F.LengthOfFlight,F.FlightNumber
FROM Flight F
WHERE F.LengthOfFlight >= ALL
(SELECT F2.LengthOfFlight
 FROM Flight F2) --select longest flights

 SELECT F.LengthOfFlight,F.FlightNumber
FROM Flight F
WHERE F.LengthOfFlight >=
(SELECT MAX(F2.LengthOfFlight)
 FROM Flight F2)

 SELECT H.HubName
FROM Hub H
WHERE H.Reputation <= ALL
(SELECT H2.Reputation
 FROM Hub H2) --select worst hubs

 SELECT H.HubName
FROM Hub H
WHERE H.Reputation <=
(SELECT MIN(H2.Reputation)
 FROM Hub H2) --select worst hubs
 

 SELECT H.HubName
 FROM Hub H
 WHERE H.HId IN 
 (SELECT A.HId
 FROM Aircraft A) --select hubs with aircrafts

  SELECT H.HubName
 FROM Hub H
 WHERE H.HId =ANY 
 (SELECT A.HId
 FROM Aircraft A)



 SELECT A.AircraftName
 FROM Aircraft A
 WHERE A.AId IN 
 (SELECT F.AId
 FROM Flight F)--select aircrafts with flights

  SELECT A.AircraftName
 FROM Aircraft A
 WHERE A.AId = ANY
 (SELECT F.AId
 FROM Flight F)



 --i) gresit

 --SELECT F.LengthOfFlight,F.FlightNumber
--FROM Flight F
--WHERE F.LengthOfFlight >
--(SELECT F2.LengthOfFlight 
-- FROM Flight F2) --select longest flights





--restul


--SELECT F.FlightNumber
--FROM Flight F
--WHERE H.HubCode is not null
--GROUP BY H.Reputation --select the most frequent flights
--HAVING COUNT(*)>1

SELECT TOP 5 H.HubName, H.Reputation
FROM Hub H
ORDER BY H.Reputation DESC

SELECT TOP 5 F.LengthOfFlight, F.FlightNumber
FROM Flight F
ORDER BY F.LengthOfFlight DESC