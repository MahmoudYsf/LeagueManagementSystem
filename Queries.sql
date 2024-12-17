-->display all registered league members 
SELECT * FROM Members;
-->1- Players 
SELECT * FROM Players;
-->2-Coaches
SELECT * FROM Coaches;
-->3-Staff
SELECT * FROM STAFF;
-->4-Owners
SELECT * FROM Owners;
-->5-sum of all salaries in barcelona;
SELECT SUM(Salary) AS salariesbarca$ FROM Contracts c JOIN Teams t ON c.TeamID=t.OrganizationID WHERE t.TeamName='FC Barcelona';
-->6-owners of barcelona and their percentages and networth
SELECT m.FirstName, m.LastName, o.OwnerShipPercentage , oo.NetWorth AS Networth$ FROM OwnerShips o JOIN Teams t ON o.TeamID= t.OrganizationID
JOIN Organizations e ON t.OrganizationID =e.OrganizationID  JOIN Members m ON o.OwnerID = m.MemberID JOIN Owners oo ON oo.MemberID=m.MemberID WHERE t.TeamName ='FC Barcelona';
-->7-display all fans that have a membership
SELECT * FROM FanMemberships;
-->8-display organization(teams and league)
SELECT * FROM Organizations;
-->9-number of teams in spanish league
SELECT TotalTeams AS NumOfSpanishTeams FROM Leagues JOIN Organizations ON Leagues.OrganizationID = Organizations.OrganizationID AND Nation = 'Spain';
-->10-all teams that play in spain
SELECT * FROM Teams JOIN Organizations ON Teams.OrganizationID = Organizations.OrganizationID AND Nation = 'Spain';
-->11-Players That play in midfield
SELECT * FROM Players p Join Members m ON p.MemberID = m.MemberID WHERE p.Position= 'Midfielder';
-->12- Highest Salary in Barcelona and name of members
SELECT  c.Salary AS HighstSalaryInFCB, m.FirstName,m.LastName
FROM Contracts c JOIN Members m ON c.ContractID = m.ContractID
WHERE c.TeamID = 1 AND c.Salary = (SELECT MAX(Salary) FROM Contracts WHERE TeamID = 1);
-->13-Coach of Atletico Madrid with style and years of experience
SELECT m.FirstName,m.LastName,c.Style, c.YearsOfExperience FROM Organizations o JOIN Members m ON o.OrganizationID = m.TeamID Join Coaches c ON c.MemberID = m.MemberID
WHERE o.Name='Atletico Madrid';
-->14-All Events
SELECT * FROM Events;
-->15-Matches
SELECT * FROM Matches;
-->16-Training Sessions
SELECT * FROM TrainingSessions;
-->17-Stats From Players that played Match 1
SELECT * FROM Performances p JOIN Members m ON p.PlayerID= m.MemberID JOIN Events e ON e.EventID= p.MatchID WHERE p.MatchID=1;
-->18-Coach that will Instruct Session 1
SELECT m.FirstName, m.LastName FROM TrainingSessions t JOIN Events e ON e.EventID = t.EventID JOIN Members m ON m.MemberID = t.CoachID WHERE e.EventID=3;
-->19-Stadiums
SELECT *FROM Stadiums;
-->20-Where did the first match happen and whats the cpacity
SELECT s.StadiumName,s.Capacity,s.Location FROM  Events e JOIN Stadiums s ON s.StadiumID = e.StadiumID WHERE e.EventID=1;
-->21- Order Leagues by Number of teams ascending
SELECT o.Name, l.TotalTeams FROM Leagues l JOIN Organizations o ON o.OrganizationID = l.OrganizationID ORDER BY l.TotalTeams ASC;
-->22-count members of every team
SELECT  o.Name, COUNT(*) AS MemberCount FROM Members m JOIN Teams t ON m.TeamID = t.OrganizationID JOIN  Organizations o ON t.OrganizationID = o.OrganizationID GROUP BY  o.OrganizationID, o.Name;
-->23-Stadium with highest capacity
SELECT StadiumName, Capacity FROM Stadiums WHERE Capacity=(SELECT MAX(Capacity) FROM Stadiums);
-->24-ticket price for match 1
SELECT Price FROM TicketSales WHERE MatchID= 1;
-->25-fans that will attend match 1
SELECT * FROM FanMemberships f JOIN TicketSales t ON t.FanID=f.MembershipID WHERE t.MatchID= 1;
-->26-Tranfers from FCB TO RM
SELECT m.FirstName, m.LastName,t.TransferDate,t.TransferFee FROM Transfers t JOIN Members m ON m.MemberID= t.PlayerID WHERE ToTeamID=2 AND FromTeamID=1;
-->27-Highest Scoring Player for FCB in match 1
SELECT m.FirstName,m.LastName,MAX(p.GoalsScored) FROM Performances p JOIN Members m ON m.MemberID = p.PlayerID WHERE p.MatchID=1 AND m.TeamID=1 GROUP BY p.MatchID,m.FirstName,m.LastName ;
-->28-Teams with players that have the awards in 2024
SELECT DISTINCT t.TeamName FROM Teams t
JOIN Members p ON t.OrganizationID = p.TeamID 
WHERE p.MemberID IN (SELECT a.PlayerID FROM Awards a WHERE a.AwardYear = 2024 );
-->29-players withthe highest count of awards
SELECT DISTINCT m.FirstName, m.LastName
FROM Members m JOIN Awards a ON a.PlayerID = m.MemberID
GROUP BY m.MemberID, m.FirstName, m.LastName
HAVING COUNT(a.PlayerID) = (SELECT MAX(PlayerAwards) FROM ( SELECT COUNT(*) AS PlayerAwards FROM Awards GROUP BY PlayerID) AS AwardCounts);
-->30-sponsors
SELECT * FROM Sponsors;
-->31-Sponsor of FCB
SELECT s.SponsorName, s.SponsorType, o.Name FROM Sponsors s JOIN SponserShips ss ON S.SponsorID = ss.SponsorID JOIN Organizations o ON o.OrganizationID= ss.TeamID WHERE o.OrganizationID=1;
-->32-merchendise
SELECT * FROM Merchandises;
-->33 -The team with highest shirt price
SELECT ProductName FROM Merchandises WHERE Price =(SELECT MAX(Price) FROM Merchandises);
select * from Players;