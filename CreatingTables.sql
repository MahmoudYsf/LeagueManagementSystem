USE LeagueManagementSystem;

-- 1. Organizations table (independent)
CREATE TABLE Organizations (
  OrganizationID INT PRIMARY KEY,
  Name VARCHAR(255) UNIQUE NOT NULL,
  Nation VARCHAR(255) NOT NULL,
  OrganizationType VARCHAR(50) CHECK (OrganizationType IN ('Team', 'League')) NOT NULL
);

CREATE TABLE Stadiums (
  StadiumID INT PRIMARY KEY,
  StadiumName VARCHAR(255) NOT NULL,
  Location VARCHAR(255) NOT NULL,
  Capacity INT NOT NULL,
  MaintenanceCost DECIMAL(10, 2) NOT NULL
);

-- 3. Sponsors table (independent)
CREATE TABLE Sponsors (
  SponsorID INT PRIMARY KEY,
  SponsorName VARCHAR(255) NOT NULL,
  SponsorType VARCHAR(255) NOT NULL,
  SponsorDate DATE NOT NULL
);

-- 4. Leagues table (depends on Organizations)
CREATE TABLE Leagues (
  OrganizationID INT PRIMARY KEY,
  Season INT NOT NULL,
  TotalTeams INT NOT NULL,
  FOREIGN KEY (OrganizationID) REFERENCES Organizations(OrganizationID) ON DELETE CASCADE
);

-- 5. Teams table (depends on Organizations, Stadiums, and Leagues)
CREATE TABLE Teams (
  OrganizationID INT PRIMARY KEY,
  TeamName VARCHAR(255) UNIQUE NOT NULL,
  HomeStadium INT NOT NULL,
  LeagueID INT NOT NULL,
  EstablishedYear INT NOT NULL,
  FOREIGN KEY (HomeStadium) REFERENCES Stadiums(StadiumID),
  FOREIGN KEY (OrganizationID) REFERENCES Organizations(OrganizationID),
  FOREIGN KEY (LeagueID) REFERENCES Leagues(OrganizationID) ON DELETE CASCADE
);

-- 6. Contracts table (depends on Teams)
CREATE TABLE Contracts (
  ContractID INT PRIMARY KEY,
  TeamID INT,
  Salary DECIMAL(10, 2) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  FOREIGN KEY (TeamID) REFERENCES Teams(OrganizationID)
);

-- 7. Members table (depends on Teams, Contracts)
CREATE TABLE Members (
  MemberID INT PRIMARY KEY,
  TeamID INT,
  ContractID INT NOT NULL,
  FirstName VARCHAR(255) NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  ContactNumber VARCHAR(20) UNIQUE,
  Email VARCHAR(255) UNIQUE,
  Nationality VARCHAR(50),
  DateOfBirth DATE,
  MemberType VARCHAR(50) CHECK (MemberType IN ('Player', 'Staff', 'Coach', 'Owner')) NOT NULL,
  FOREIGN KEY (TeamID) REFERENCES Teams(OrganizationID) ON DELETE CASCADE,
  FOREIGN KEY (ContractID) REFERENCES Contracts(ContractID)
);

-- 8. Players table (depends on Members)
CREATE TABLE Players (
  MemberID INT PRIMARY KEY,
  Position VARCHAR(50) CHECK (Position IN ('Goalkeeper', 'Defender', 'Midfielder', 'Attacker')) NOT NULL,
  ShirtNumber INT UNIQUE,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE
);

-- 9. Coaches table (depends on Members)
CREATE TABLE Coaches (
  MemberID INT PRIMARY KEY,
  YearsOfExperience INT,
  Style VARCHAR(50) CHECK (Style IN ('Defence', 'Position', 'Attack', 'Offside Trap', 'CounterAttack', 'Direct Attack', 'Long Passing')) NOT NULL,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE
);

-- 10. Staff table (depends on Members)
CREATE TABLE Staff (
  MemberID INT PRIMARY KEY,
  Role VARCHAR(255) NOT NULL,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE
);

-- 11. Owners table (depends on Members)
CREATE TABLE Owners (
  MemberID INT PRIMARY KEY,
  NetWorth INT NOT NULL,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE
);

-- 12. OwnerShips table (depends on Teams and Owners)
CREATE TABLE OwnerShips (
  TeamID INT PRIMARY KEY,
  OwnerID INT NOT NULL,
  OwnerShipPercentage INT NOT NULL,
  FOREIGN KEY (OwnerID) REFERENCES Owners(MemberID) ON DELETE CASCADE,
  FOREIGN KEY (TeamID) REFERENCES Teams(OrganizationID)
);

-- 13. Events table (depends on Stadiums)
CREATE TABLE Events (
  EventID INT PRIMARY KEY,
  EventType VARCHAR(50) CHECK (EventType IN ('Match', 'Training')) NOT NULL,
  StartDate TIME NOT NULL,
  EndDate TIME NOT NULL,
  StadiumID INT NOT NULL,
  FOREIGN KEY (StadiumID) REFERENCES Stadiums(StadiumID) ON DELETE CASCADE
);

-- 14. Matches table (depends on Events, Teams, and Leagues)
CREATE TABLE Matches (
  EventID INT PRIMARY KEY,
  LeagueID INT NOT NULL,
  HomeTeamID INT NOT NULL,
  AwayTeamID INT NOT NULL,
  Result VARCHAR(255),
  FOREIGN KEY (EventID) REFERENCES Events(EventID),
  FOREIGN KEY (LeagueID) REFERENCES Leagues(OrganizationID),
  FOREIGN KEY (HomeTeamID) REFERENCES Teams(OrganizationID),
  FOREIGN KEY (AwayTeamID) REFERENCES Teams(OrganizationID)
);

-- 15. TrainingSessions table (depends on Events, Teams, and Coaches)
CREATE TABLE TrainingSessions (
  EventID INT PRIMARY KEY,
  CoachID INT NOT NULL,
  TeamID INT NOT NULL,
  FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE,
  FOREIGN KEY (CoachID) REFERENCES Coaches(MemberID),
  FOREIGN KEY (TeamID) REFERENCES Teams(OrganizationID) ON DELETE CASCADE
);

-- 16. Performances table (depends on Matches and Players)
CREATE TABLE Performances (
  MatchID INT NOT NULL,
  PlayerID INT NOT NULL,
  GoalsScored INT DEFAULT 0,
  Assists INT DEFAULT 0,
  YellowCards INT DEFAULT 0,
  RedCards INT DEFAULT 0,
  MinutesPlayed INT NOT NULL,
  FOREIGN KEY (MatchID) REFERENCES Matches(EventID) ON DELETE CASCADE,
  FOREIGN KEY (PlayerID) REFERENCES Players(MemberID) ON DELETE CASCADE,
  PRIMARY KEY (MatchID, PlayerID)
);

-- 17. Transfers table (depends on Players, Teams, and Leagues)
CREATE TABLE Transfers (
  TransferID INT PRIMARY KEY,
  PlayerID INT NOT NULL,
  LeagueID INT NOT NULL,
  FromTeamID INT NOT NULL,
  ToTeamID INT NOT NULL,
  TransferFee DECIMAL(10, 2) NOT NULL,
  TransferDate DATE NOT NULL,
  FOREIGN KEY (PlayerID) REFERENCES Players(MemberID) ON DELETE CASCADE,
  FOREIGN KEY (LeagueID) REFERENCES Leagues(OrganizationID),
  FOREIGN KEY (FromTeamID) REFERENCES Teams(OrganizationID),
  FOREIGN KEY (ToTeamID) REFERENCES Teams(OrganizationID)
);

-- 18. Merchandises table (depends on Teams)
CREATE TABLE Merchandises (
  MerchandiseID INT PRIMARY KEY,
  TeamID INT NOT NULL,
  ProductName VARCHAR(255) NOT NULL,
  Price DECIMAL(10, 2) NOT NULL,
  StockQuantity INT NOT NULL,
  FOREIGN KEY (TeamID) REFERENCES Teams(OrganizationID) ON DELETE CASCADE
);

-- 19. FanMemberships table (independent)
CREATE TABLE FanMemberships (
  MembershipID INT PRIMARY KEY,
  FanName VARCHAR(255) NOT NULL,
  Email VARCHAR(255) UNIQUE NOT NULL,
  MembershipType VARCHAR(255) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL
);

-- 20. TicketSales table (depends on Matches, Stadiums, and FanMemberships)
CREATE TABLE TicketSales (
  TicketID INT PRIMARY KEY,
  MatchID INT NOT NULL,
  StadiumID INT NOT NULL,
  FanID INT NOT NULL,
  Price DECIMAL(10, 2) NOT NULL,
  SaleDate DATE NOT NULL,
  FOREIGN KEY (MatchID) REFERENCES Matches(EventID) ON DELETE CASCADE,
  FOREIGN KEY (StadiumID) REFERENCES Stadiums(StadiumID) ON DELETE CASCADE,
  FOREIGN KEY (FanID) REFERENCES FanMemberships(MembershipID) ON DELETE CASCADE
);

-- 21. Sponsorships table (depends on Teams and Sponsors)
CREATE TABLE SponserShips (
  TeamID INT,
  SponsorID INT,
  SponsorshipAmount DECIMAL(10, 2) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  FOREIGN KEY (SponsorID) REFERENCES Sponsors(SponsorID) ON DELETE CASCADE,
  FOREIGN KEY (TeamID) REFERENCES Teams(OrganizationID) ON DELETE CASCADE,
  PRIMARY KEY (TeamID, SponsorID)
);

-- 22. Awards table (depends on Players)
CREATE TABLE Awards (
  AwardID INT NOT NULL,
  PlayerID INT NOT NULL,
  AwardName VARCHAR(255) NOT NULL,
  AwardYear INT NOT NULL,
  FOREIGN KEY (PlayerID) REFERENCES Players(MemberID) ON DELETE CASCADE,
  PRIMARY KEY (PlayerID, AwardID)
);