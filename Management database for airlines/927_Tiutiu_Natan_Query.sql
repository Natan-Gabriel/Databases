--my query is a solution to the real problem caused by Donald Trump (US President) in 2017 when he banned the citizens from 7 islamic countries 
--from entering the USA(for simplicity we consider that all  citizens from islamic countries were banned)
--therefore all airlines (including Emirates-my database being the Emirates' database) which had muslim persons as pilots cancelled all
--their flights to USA
--In my database I have a FULL JOIN between 2 MANY-TO-MANY relations Pilot-Aircraft-Destination and I find all muslim PILOTS who fly to USA as DESTINATION
--Then i'm sending a message(by setting the status) to each passenger on such flights that their flight was cancelled
--I also and refund the cost of flight to clients(before delete them from the flight) and substact a 8% from pilots' salaries because they didn't 
--operate a flight
--THen i delete each passenger from such flights using IN operator and a SUBQUERY
--Then i cancel (by deleting) each such flight using ANY operator and a SUBQUERY
--at the beginning I populte my database
use [bonus]
CREATE TABLE Hub
(HId INT PRIMARY KEY IDENTITY,
HubName varchar(100),
HubCode varchar(5),
Price int,
Reputation INT
)
CREATE TABLE Airport
(AId INT FOREIGN KEY REFERENCES Hub(HId),
AirportName varchar(100) NOT NULL,
AirportCode varchar(5) NOT NULL,
NumberOfSlots INT,
Cost INT,
Reputation INT
CONSTRAINT pk_HubAirport PRIMARY KEY(AId)
)

CREATE TABLE Aircraft
(AId INT PRIMARY KEY IDENTITY,
AircraftName varchar(100) NOT NULL,
HId INT FOREIGN KEY REFERENCES Hub(HId)
)

CREATE TABLE Destination
(DId INT PRIMARY KEY IDENTITY,
DestinationName varchar(100),
CountryName varchar(100) 
)



CREATE TABLE Flight
(FId INT PRIMARY KEY IDENTITY,
FlightNumber varchar(100) NOT NULL,
LengthOfFlight int,
RouteOfFlight varchar(100) NOT NULL,
AId INT FOREIGN KEY REFERENCES Aircraft(AId),
DId INT Foreign KEY REFERENCES Destination(DId)
)

CREATE TABLE Passenger
(PId INT PRIMARY KEY IDENTITY,
FId INT Foreign KEY REFERENCES Flight(FId),
_Stautus varchar(100) ,
Budget int
)

CREATE TABLE Pilot
(PId INT PRIMARY KEY IDENTITY,
PilotName varchar(100) NOT NULL,
Religion varchar(100),
PilotReputation int,
Seniority int,
Salary int
)

CREATE TABLE isPiloted
(
AId INT FOREIGN KEY REFERENCES Aircraft(AId),
PId INT FOREIGN KEY REFERENCES Pilot(PId),
PilotedHours int,
CONSTRAINT pk_Aircraft PRIMARY KEY(AId,PId)
)



CREATE TABLE R
(RId INT PRIMARY KEY IDENTITY,
M INT not null,
N INT not null,
P INT,
Q INT,
O INT
)

--DELETE FROM Passenger WHERE 1=1;
--DELETE FROM Flight WHERE 1=1;
--DELETE FROM isPiloted WHERE 1=1;
--DELETE FROM Aircraft WHERE 1=1;
--DELETE FROM Hub WHERE 1=1;
--DELETE FROM Pilot WHERE 1=1;
--DELETE FROM Destination WHERE 1=1;

--DBCC CHECKIDENT('Hub',RESEED,0)
--DBCC CHECKIDENT('Aircraft',RESEED,0)
--DBCC CHECKIDENT('Flight',RESEED,0)
--DBCC CHECKIDENT('Passenger',RESEED,0)
--DBCC CHECKIDENT('Pilot',RESEED,0)
--DBCC CHECKIDENT('Destination',RESEED,0)


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

INSERT INTO Destination VALUES ('Roma','Italy')
INSERT INTO Destination VALUES ('New York','USA')
INSERT INTO Destination VALUES ('Chicago','USA')
INSERT INTO Destination VALUES ('San Francisco','USA')
INSERT INTO Destination VALUES ('Los Angeles','USA')
INSERT INTO Destination VALUES ('Doha','Qatar')

INSERT INTO Flight VALUES ('DL0047',8,'UY',3,1)
INSERT INTO Flight VALUES ('BA0751',1,'HB',1,2)
INSERT INTO Flight VALUES ('FY9080',7,'UU',2,3)
INSERT INTO Flight VALUES ('DL0047',7,'PO',1,4)
INSERT INTO Flight VALUES ('FY9080',6,'KU',3,5)
INSERT INTO Flight VALUES ('AF0065',8,'LA',4,6)
INSERT INTO Flight VALUES ('AAAA',8,'USA',4,2)
select* from Flight
INSERT INTO Passenger VALUES (2,'',500)
INSERT INTO Passenger VALUES (3,'',600)
INSERT INTO Passenger VALUES (4,'',700)
INSERT INTO Passenger VALUES (5,'',800)
INSERT INTO Passenger VALUES (1,'',900)
INSERT INTO Passenger VALUES (2,'',1000)
INSERT INTO Passenger VALUES (3,'',1100)




INSERT INTO Pilot VALUES ('Muhamad','Islam',10,9,1000)
INSERT INTO Pilot VALUES ('Yussuf','Islam',8,9,2000)
INSERT INTO Pilot VALUES ('Ali','Islam',7,3,2000)
INSERT INTO Pilot VALUES ('Andrew','Christianity',7,7,2000)
INSERT INTO Pilot VALUES ('George','Budhism',6,2,1000)

select * from Pilot
INSERT INTO isPiloted VALUES (1,4,100)
INSERT INTO isPiloted VALUES (2,3,300)
INSERT INTO isPiloted VALUES (3,2,100)
INSERT INTO isPiloted VALUES (4,1,300)



--drop table newTable
select p.PId,p.PilotName,p.CountryName,p.FId,p.FlightNumber,p.Religion INTO newTable
from(SELECT p1.DestinationName,p1.CountryName,p2.PId,p2.PilotName,p1.FId,p1.FlightNumber,p2.Religion
	FROM(SELECT A.AId, D.DestinationName,D.CountryName,F.FId,F.FlightNumber
		FROM Aircraft A
		INNER JOIN Flight F ON A.AId =
		F.AId
		FULL JOIN Destination D ON F.DId 
		=D.DId) as p1
	INNER JOIN 
		(SELECT P.PId,P.PilotName,P.Religion, A.AId
		FROM Pilot P
		INNER JOIN isPiloted I ON P.PId =
		I.PId
		INNER JOIN Aircraft A ON I.AId 
		=A.AId)as p2
		on p2.AId=p1.AId) as p
where p.Religion='Islam' and p.CountryName='USA'
select * from newTable

select * from Passenger

UPDATE Passenger
SET _Stautus = 'Your flight was cancelled.Visit our website'
WHERE FId=any(Select FId from newTable )

UPDATE Passenger
SET Budget = Budget+500
WHERE FId=any(Select FId from newTable )

DELETE FROM Passenger 
WHERE FId in (Select FId from newTable )

select * from Passenger


UPDATE Pilot
SET Salary = Salary*0.92
WHERE PId=any(Select PId from newTable )

select * from Flight

DELETE FROM Flight 
WHERE FId=any(Select FId from newTable )

select * from Flight


select AVG(LengthOfFlight)--FId,AVG(FId) 
from Flight
--group by FId,FlightNumber
having AVG(LengthOfFlight)>2

SELECT M--,COUNT(DISTINCT P)
FROM R

insert into R values(1,2,3,1,4)
insert into R values(5,6,7,1,8)
insert into R values(9,10,11,1,12)
insert into R values(13,14,15,1,16)
insert into R values(17,18,19,1,20)

SELECT Q,P
FROM R
GROUP BY Q,P
HAVING count(RId) <> 100
order by P 

create table ana
(a int,b int)

create table ana1
(a int,b int)

insert into ana values (1,1)
insert into ana values (2,2)
insert into ana1 values (1,1)
insert into ana1 values (2,2)

SELECT * FROM ana intersect
SELECT * FROM ana1

--SELECT * FROM ana NATURAL JOIN ana1

select * from ana cross join  ana1
where ana.a=ana1.a



SELECT RId
FROM R
intersect
SELECT RId
FROM R

--SELECT * FROM ana1 NATURAL JOIN ana ;