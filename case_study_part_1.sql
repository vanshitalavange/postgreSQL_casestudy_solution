-- PART 1: TABLE CREATION AND ADDING INTEGRITY CONSTRAINTS

-- create database
create database tennis_club;

-- create table players
create table players 
(
	playerno int primary key,
	surname varchar(20),
	initials varchar(10),
	birth_date date constraint players_birth_date_check check(extract(year from birth_date) < joined),
	sex char(1) constraint players_sex_check check(sex='M' or sex='F'),
	joined int constraint players_joined_check check(joined > 1969),
	street varchar(30),
	houseno varchar(10),
	postcode varchar(6) constraint players_postcode_check check(length(postcode)=6),
	town varchar(20),
	phoneno varchar(10) unique,
	leagueno int unique
);

-- create table teams
create table teams 
(
	teamno int primary key,
	playerno int,
	division varchar(6) constraint teams_division_check check(division='first' or division='second'),
	foreign key(playerno) references players(playerno) on delete cascade
);


-- create table matches
create table matches
(
	matchno int primary key, 
	teamno int,
	playerno int,
	won smallint not null constraint matches_won_check check(won >= 0 and won <= 3),
	lost smallint not null constraint matches_lost_check check(lost >= 0 and lost <= 3),
	foreign key(playerno) references players(playerno) on delete cascade,
	foreign key(teamno) references teams(teamno) on delete cascade
);

-- create table penalties
create table penalties
(
	paymentno int primary key,
	playerno int,
	payment_date date constraint penalties_payment_date_check check(payment_date >= '1970-01-01'),
	amount numeric(10,2),
	foreign key(playerno) references players(playerno) on delete cascade	
);

-- create table committee_members
create table committee_members
(
	playerno int,
	begin_date date constraint committee_members_begin_date_check check(begin_date >= '1990-01-01'),
	end_date date constraint committee_members_end_date_check check(end_date > begin_date),
	post varchar(20),
	primary key(playerno,begin_date),
	foreign key(playerno) references players(playerno) on delete cascade
)