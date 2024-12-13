import random
from faker import Faker

fake = Faker()

# Generate data for Owners
def generate_owners(num_owners):
    owners = []
    for i in range(num_owners):
        member_id = i + 1  # Assuming MemberID starts from 1
        net_worth = random.randint(500000, 10000000)  # Random net worth
        owners.append((member_id, net_worth))
    return owners

# Generate data for OwnerShips
def generate_ownerships(num_teams, owners):
    ownerships = []
    for team_id in range(1, num_teams + 1):
        owner = random.choice(owners)
        ownership_percentage = 100  # Assuming full ownership for simplicity
        ownerships.append((team_id, owner[0], ownership_percentage))
    return ownerships

# Generate data for Sponsorships
def generate_sponsorships(num_sponsorships, num_teams):
    sponsorships = []
    for _ in range(num_sponsorships):
        team_id = random.randint(1, num_teams)
        sponsor_id = random.randint(1, 10)  # Assuming 10 sponsors
        amount = random.uniform(100000, 10000000)
        start_date = fake.date_this_year()
        end_date = fake.date_between(start_date=start_date, end_date="+1y")
        sponsorships.append((team_id, sponsor_id, round(amount, 2), start_date, end_date))
    return sponsorships

# Generate data for Awards
def generate_awards(num_awards, num_players):
    awards = []
    for i in range(num_awards):
        player_id = random.randint(1, num_players)
        award_name = fake.sentence(nb_words=2)
        award_year = random.randint(2000, 2024)
        awards.append((i + 1, player_id, award_name, award_year))
    return awards

# Generate data for TicketSales
def generate_ticket_sales(num_sales, num_matches, num_fans, num_stadiums):
    sales = []
    for i in range(num_sales):
        ticket_id = i + 1
        match_id = random.randint(1, num_matches)
        stadium_id = random.randint(1, num_stadiums)
        fan_id = random.randint(1, num_fans)
        price = random.uniform(50, 500)
        sale_date = fake.date_this_year()
        sales.append((ticket_id, match_id, stadium_id, fan_id, round(price, 2), sale_date))
    return sales

# Generate data for Transfers
def generate_transfers(num_transfers, num_players, num_teams, num_leagues):
    transfers = []
    for i in range(num_transfers):
        transfer_id = i + 1
        player_id = random.randint(1, num_players)
        league_id = random.randint(1, num_leagues)
        from_team = random.randint(1, num_teams)
        to_team = random.randint(1, num_teams)
        while to_team == from_team:
            to_team = random.randint(1, num_teams)
        fee = random.uniform(100000, 10000000)
        transfer_date = fake.date_this_year()
        transfers.append((transfer_id, player_id, league_id, from_team, to_team, round(fee, 2), transfer_date))
    return transfers

# Example usage
if __name__ == "__main__":
    owners = generate_owners(10)
    ownerships = generate_ownerships(5, owners)
    sponsorships = generate_sponsorships(10, 5)
    awards = generate_awards(5, 20)
    ticket_sales = generate_ticket_sales(10, 5, 50, 5)
    transfers = generate_transfers(10, 20, 10, 5)

    print("Owners:", owners)
    print("Ownerships:", ownerships)
    print("Sponsorships:", sponsorships)
    print("Awards:", awards)
    print("Ticket Sales:", ticket_sales)
    print("Transfers:", transfers)
