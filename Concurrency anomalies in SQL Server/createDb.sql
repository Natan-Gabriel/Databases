CREATE TABLE Aircraft
(AId INT PRIMARY KEY IDENTITY,
AircraftRegistration varchar(100) unique NOT NULL,
AircraftType varchar(100) NOT NULL
)

CREATE TABLE Pilot
(PId INT PRIMARY KEY IDENTITY,
PilotName varchar(100) unique NOT NULL,
PilotReputation int
)

CREATE TABLE isPiloted
(
AId INT FOREIGN KEY REFERENCES Aircraft(AId),
PId INT FOREIGN KEY REFERENCES Pilot(PId),
PilotedHours int,
CONSTRAINT pk_Aircraft PRIMARY KEY(AId,PId)
)


CREATE TABLE Hub
(HId INT PRIMARY KEY IDENTITY,
HubName varchar(100)
)

create TABLE GATE
(GId INT PRIMARY KEY IDENTITY,
GateName varchar(100)
)


create TABLE Logger
(LId INT PRIMARY KEY IDENTITY,
LogMessage varchar(100)
)
