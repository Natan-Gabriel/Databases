CREATE TABLE Hub
(HId INT PRIMARY KEY IDENTITY,
HubName varchar(100),
HubCode varchar(5),
Price int,
Reputation INT
)


CREATE TABLE Aircraft
(AId INT PRIMARY KEY IDENTITY,
AircraftName varchar(100) NOT NULL,
HId INT FOREIGN KEY REFERENCES Hub(HId)
)



CREATE TABLE Salary
(SId INT PRIMARY KEY IDENTITY,
Quantum varchar(100) NOT NULL
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

insert into Salary values (100)
insert into Pilot values ('Pilot',10,5,1)
select * from Pilot
select * from isPiloted
