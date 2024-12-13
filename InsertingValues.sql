-- Insert into Organizations (Foundation for Teams and Leagues)
INSERT INTO Organizations (OrganizationID, Name, Nation, OrganizationType)
VALUES
(1, 'FC Barcelona', 'Spain', 'Team'),
(2, 'Real Madrid', 'Spain', 'Team'),
(3, 'La Liga', 'Spain', 'League'),
(4, 'Atletico Madrid', 'Spain', 'Team'),
(5, 'Sevilla FC', 'Spain', 'Team'),
(6, 'Premier League', 'England', 'League'),
(7, 'Manchester United', 'England', 'Team'),
(8, 'Liverpool FC', 'England', 'Team');

-- Insert into Stadiums (Required by Teams)
INSERT INTO Stadiums (StadiumID, StadiumName, Location, Capacity, MaintenanceCost)
VALUES
(1, 'Camp Nou', 'Barcelona, Spain', 99354, 1500000.00),
(2, 'Santiago Bernabeu', 'Madrid, Spain', 81044, 1200000.00),
(3, 'Wembley Stadium', 'London, England', 90000, 2000000.00),
(4, 'Old Trafford', 'Manchester, England', 74800, 1000000.00),
(5, 'Anfield', 'Liverpool, England', 54000, 900000.00);

-- Insert into Sponsors (Independent)
INSERT INTO Sponsors (SponsorID, SponsorName, SponsorType, SponsorDate)
VALUES
(1, 'Nike', 'Apparel', '2024-01-01'),
(2, 'Adidas', 'Apparel', '2024-02-01'),
(3, 'Emirates', 'Airline', '2023-12-01'),
(4, 'Coca-Cola', 'Beverage', '2023-11-01');

-- Insert into Leagues (Requires Organizations)
INSERT INTO Leagues (OrganizationID, Season, TotalTeams)
VALUES
(3, 2024, 20),
(6, 2024, 20);

-- Insert into Teams (Requires Organizations, Leagues, and Stadiums)
INSERT INTO Teams (OrganizationID, TeamName, HomeStadium, LeagueID, EstablishedYear)
VALUES
(1, 'FC Barcelona', 1, 3, 1899),
(2, 'Real Madrid', 2, 3, 1902),
(4, 'Atletico Madrid', 3, 3, 1903),
(5, 'Sevilla FC', 4, 3, 1890),
(7, 'Manchester United', 4, 6, 1878),
(8, 'Liverpool FC', 5, 6, 1892);

-- Insert into Contracts (Required by Members)
INSERT INTO Contracts (ContractID, TeamID, Salary, StartDate, EndDate)
VALUES
(1, 1, 14000000.00, '2024-01-01', '2026-01-01'),
(2, 2, 17000000.00, '2024-01-01', '2026-01-01'),
(3, 4, 15000000.00, '2024-01-01', '2026-01-01'),
(4, 4, 16000000.00, '2024-01-01', '2026-01-01'),
(5, 5, 18000000.00, '2024-01-01', '2026-01-01'),
(6, 1, 19000000.00, '2024-01-01', '2026-01-01'),
(7, 2, 20000000.00, '2024-01-01', '2026-01-01'),
(8, 7, 21000000.00, '2024-01-01', '2026-01-01'),
(9, 4, 22000000.00, '2024-01-01', '2026-01-01'),
(10, 5, 23000000.00, '2024-01-01', '2026-01-01');


-- Insert into Members (Depends on Teams and Contracts)
INSERT INTO Members (MemberID, TeamID, FirstName, LastName, ContactNumber, Email, Nationality, DateOfBirth, MemberType, ContractID)
VALUES
(1, 1, 'Lionel', 'Messi', '1234567890', 'lionel.messi@barcelona.com', 'Argentina', '1987-06-24', 'Player', 1),
(2, 2, 'Cristiano', 'Ronaldo', '0987654321', 'cristiano.ronaldo@realmadrid.com', 'Portugal', '1985-02-05', 'Player', 2),
(3, 1, 'Gerard', 'Pique', '1122334455', 'gerard.pique@barcelona.com', 'Spain', '1987-02-02', 'Player', 3),
(4, 7, 'Paul', 'Pogba', '2233445566', 'paul.pogba@manutd.com', 'France', '1993-03-15', 'Player', 4),
(5, 8, 'Mohamed', 'Salah', '3344556677', 'mohamed.salah@liverpool.com', 'Egypt', '1992-06-15', 'Player',5),
(6, 5, 'Diego', 'Simeone', '4455667788', 'diego.simeone@atleticomadrid.com', 'Argentina', '1970-04-28', 'Coach', 6),
(7, 4, 'Julen', 'Lopetegui', '5566778899', 'julen.lopetegui@sevillafc.com', 'Spain', '1966-08-28', 'Coach', 7);

INSERT INTO Members (MemberID, TeamID, FirstName, LastName, ContactNumber, Email, Nationality, DateOfBirth, MemberType, ContractID)
VALUES
(8, 2, 'City', 'Group', '123456', 'james.bat@city.com', 'UAE', '1987-06-14', 'Owner', 8),
(9, 2, 'james', 'firm', '087654321', 'james.jj@firm.com', 'Portugal', '1985-04-05', 'Owner', 9),
(10, 1, 'Max', 'Cold', '122334455', 'Max.maxi@barcelona.com', 'Spain', '1987-07-02', 'Staff',10 );

-- Insert into Players (Depends on Members)
INSERT INTO Players (MemberID, Position, ShirtNumber)
VALUES
(1, 'Attacker', 10),
(2, 'Attacker', 7),
(3, 'Defender', 3),
(4, 'Midfielder', 6),
(5, 'Attacker', 11);

-- Insert into Coaches (Depends on Members)
INSERT INTO Coaches (MemberID, YearsOfExperience, Style)
VALUES
(6, 15, 'Attack'),
(7, 10, 'Defence');
INSERT INTO Staff (MemberID, Role) VALUES (10,'Stadium Maintanence');

INSERT INTO Events (EventID, EventType, StartDate, EndDate, StadiumID)
VALUES
(5, 'Match', '20:30:00', '22:00:00', 3),
(6, 'Match', '21:00:00', '22:30:00', 4);
-- Insert into Matches (Depends on Leagues and Teams)
INSERT INTO Matches (EventID, LeagueID, HomeTeamID, AwayTeamID, Result)
VALUES
(5, 3, 1, 2, 'FC Barcelona 2-1 Real Madrid'),
(6, 6, 7, 8, 'Manchester United 1-2 Liverpool FC');

-- Insert into Events (Depends on Stadiums)
INSERT INTO Events (EventID, EventType, StartDate, EndDate, StadiumID)
VALUES
(3, 'Training', '19:30:00', '21:30:00', 3),
(4, 'Training', '19:30:00', '21:30:00', 4);

-- Insert into TrainingSessions (Depends on Events and Members)
INSERT INTO TrainingSessions (EventID, CoachID, TeamID)
VALUES
(3, 6, 1),
(4, 7, 2);

-- Insert into Performances (Depends on Matches and Players)
INSERT INTO Performances (MatchID, PlayerID, GoalsScored, Assists, YellowCards, RedCards, MinutesPlayed)
VALUES
(5, 1, 1, 0, 0, 0, 90),
(5, 2, 0, 1, 1, 0, 90),
(6, 4, 1, 0, 0, 0, 90);

-- Insert into Transfers (Depends on Players and Teams)
INSERT INTO Transfers (TransferID, PlayerID, LeagueID, FromTeamID, ToTeamID, TransferFee, TransferDate)
VALUES
(1, 1, 3, 1, 2, 1000000.00, '2024-06-30'),
(2, 4, 6, 7, 8, 500000.00, '2024-07-10');

-- Insert into Merchandises (Depends on Teams)
INSERT INTO Merchandises (MerchandiseID, TeamID, ProductName, Price, StockQuantity)
VALUES
(1, 1, 'FC Barcelona Jersey', 75.00, 1000),
(2, 2, 'Real Madrid Jersey', 80.00, 800);

-- Insert into FanMemberships (Independent)
INSERT INTO FanMemberships (MembershipID, FanName, Email, MembershipType, StartDate, EndDate)
VALUES
(1, 'John Doe', 'johndoe@email.com', 'Gold', '2024-01-01', '2025-01-01'),
(2, 'Jane Smith', 'janesmith@email.com', 'Silver', '2024-01-01', '2025-01-01');

-- Insert into TicketSales (Depends on Matches and Fans)
INSERT INTO TicketSales (TicketID, MatchID, StadiumID, FanID, Price, SaleDate)
VALUES
(1, 5, 1, 1, 100.00, '2024-01-10'),
(2, 6, 5, 2, 120.00, '2024-01-15');

-- Insert into Sponsorships (Depends on Teams and Sponsors)
INSERT INTO SponserShips (TeamID, SponsorID, SponsorshipAmount, StartDate, EndDate)
VALUES
(1, 1, 5000000.00, '2024-01-01', '2025-01-01'),
(2, 2, 6000000.00, '2024-02-01', '2025-02-01');

-- Insert into Owners (Depends on Members)
INSERT INTO Owners (MemberID, NetWorth)
VALUES
(8, 1000000),
(9, 2000000);

-- Insert into OwnerShips (Depends on Teams and Owners)
INSERT INTO OwnerShips (TeamID, OwnerID, OwnerShipPercentage)
VALUES
(5, 8, 100),
(1, 9, 100);

-- Insert into Awards (Depends on Players)
INSERT INTO Awards (AwardID, PlayerID, AwardName, AwardYear)
VALUES
(1, 1, 'Ballon DOR', 2024),
(2, 2, 'Golden Boot', 2024);

