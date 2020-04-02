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



CREATE TABLE Cities
(CId INT Primary Key,
CitiesName varchar(100) not null
)

CREATE TABLE Flight
(FId INT PRIMARY KEY IDENTITY,
FlightNumber varchar(100) NOT NULL,
LengthOfFlight int,
RouteOfFlight varchar(100) NOT NULL,
AId INT FOREIGN KEY REFERENCES Aircraft(AId),
CId INT Foreign KEY REFERENCES Cities(CId)
)


CREATE TABLE Salary
(SId INT PRIMARY KEY IDENTITY,
Quantum varchar(100) NOT NULL
)

CREATE TABLE Manager
(MId INT PRIMARY KEY IDENTITY,
ManagerName varchar(100) NOT NULL,
ManagerReputation int,
Seniority int,
 SId INT FOREIGN KEY REFERENCES Salary(SId)
)

CREATE TABLE FlightAttendant
(FId INT PRIMARY KEY IDENTITY,
FlightAttendantName varchar(100) NOT NULL,
FlightAttendantReputation int,
SId INT FOREIGN KEY REFERENCES Salary(SId)
)
CREATE TABLE Pilot
(PId INT PRIMARY KEY IDENTITY,
PilotName varchar(100) NOT NULL,
PilotReputation int,
Seniority int,
SId INT FOREIGN KEY REFERENCES Salary(SId)
)

CREATE TABLE isPiloted
(
AId INT FOREIGN KEY REFERENCES Aircraft(AId),
PId INT FOREIGN KEY REFERENCES Pilot(PId),
PilotedHours int,
CONSTRAINT pk_Aircraft PRIMARY KEY(AId,PId)
)




DELETE FROM Flight WHERE 1=1;
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

INSERT INTO Hub VALUES ('Heathrow','LHR',1000,12)
INSERT INTO Hub VALUES ('Charles De Gaulle','CDG',800, 13)
INSERT INTO Hub VALUES ('Schipol','AMS', 1100,15)
INSERT INTO Hub VALUES ('Ataturk','LST',700,9)
INSERT INTO Hub VALUES ('Frankfurt','FRA', 500,15)
INSERT INTO Hub VALUES ('Malta','MLA',2000, 9)


INSERT INTO Aircraft VALUES ('Airbus a318-100', 1)
INSERT INTO Aircraft VALUES ('Airbus a380', 1)
INSERT INTO Aircraft VALUES ('Boeing 767-200', 2)
INSERT INTO Aircraft VALUES ('Boeing 777-200', 2)
INSERT INTO Aircraft VALUES ('Airbus a380', 3)
INSERT INTO Aircraft VALUES ('Boeing 777-300ER', 3)
INSERT INTO Aircraft VALUES ('Airbus a340-300', 4)
INSERT INTO Aircraft VALUES ('Boeing 747-400', 4)
INSERT INTO Aircraft VALUES ('Airbus a320-200', 5)
INSERT INTO Aircraft VALUES ('Boeing 737-700', 5)
INSERT INTO Aircraft VALUES ('Airbus a330-300', 6)
INSERT INTO Aircraft VALUES ('Boeing 737-700', 6)


INSERT INTO Cities VALUES (1,'Roma')
INSERT INTO Cities VALUES (2,'Viena')

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

