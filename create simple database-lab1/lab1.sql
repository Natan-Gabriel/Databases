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


