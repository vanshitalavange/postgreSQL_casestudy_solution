-- PART 2: POPULATING TABLES WITH DATA 

-- inserting data into players table
insert into players
values(2,'Everett','R','1948-09-01','M',1975,'Stoney Road',43,'3575NH','Stratford','070-237893',2411),
(6,'Parmenter','R','1964-06-25','M',1977,'Haseltine Lane',80,'1234KK','Stratford','070-476537',8467),
(7,'Wise', 'GWS','1963-05-11','M',1981,'Edgecombe Way',39,'9758VB','Stratford', '070-347689',NULL),
(8,'Newcastle','B','1962-07-08','F',1980,'Station Road',4,'6584RO','Inglewood', '070-458458',2983),
(27,'Collins','DD','1964-12-28','F',1983,'Long Drive',804, '8457DK', 'Eltham', '079-234857', 2513),
(28,'Collins','C','1963-06-22','F',1983,'Old Main Road',10, '1294QK', 'Midhurst', '071-659599',NULL),
(39,'Bishop','D','1956-10-29','M',1980,'Eaton Square',78, '9629CD', 'Stratford', '070-393435',NULL),
(44,'Baker','E','1963-01-09','M',1980,'Lewis Street',23, '4444LJ', 'Inglewood', '070-368753',1124),
(57,'Brown','M','1971-08-17','M',1985,'Edgecombe Way',16, '4377CB', 'Stratford', '070-473458',6409),
(83,'Hope','PK','1956-11-11','M',1982,'Magdalene Road','16A', '1812UP', 'Stratford', '070-353548',1608),
(95,'Miller','P','1963-05-14','M',1972,'High Street','33A', '5746OP', 'Douglas', '070-867564', NULL),
(100,'Parmenter','P','1963-02-28','M',1979,'Haseltine Lane',80, '1234KK', 'Stratford', '070-494593',6524),
(104,'Moorman','D','1970-05-10','F',1984,'Stout Street',65, '9437AO', 'Eltham', '079-987571',7060),
(112,'Bailey','IP','1963-10-01','F',1984,'Vixen Road',8, '6392LK', 'Plymouth', '010-548745',1319);
				
				
-- inserting data into teams table
insert into teams 
values(1,6,'first'),
(2,27,'second');
						

-- inserting data into matches table
insert into matches 
values(1,1,6,3,1),
(2,1,6,2,3),
(3,1,6,3,0),
(4,1,44,3,2),
(5,1,83,0,3),
(6,1,2,1,3),
(7,1,57,3,0),
(8,1,8,0,3),
(9,2,27,3,2),
(10,2,104,3,2),
(11,2,112,2,3),
(12,2,112,1,3),
(13,2,8,0,3);
						  
		
-- inserting data into penalties table
insert into penalties 
values(1,6,'1980-12-08',100.00),
(2,44,'1981-05-05',75.00),
(3,27,'1983-09-10',100.00),
(4,104,'1984-12-08',50.00),
(5,44,'1980-12-08',25.00),
(6,8,'1980-12-08',25.00),
(7,44,'1982-12-30',30.00),
(8,27,'1984-11-12',75.00);
							
							
-- inserting data into committee_members table
insert into committee_members 
values(2,'1990-01-01','1992-12-31','Chairman'),
(2,'1994-01-01',null,'Member'),
(6,'1990-01-01','1990-12-31','Secretary'),
(6,'1991-01-01','1992-12-31','Member'),
(6,'1992-01-01','1993-12-31','Treasurer'),
(6,'1993-01-01',null,'Chairman'),
(8,'1990-01-01','1990-12-31','Treasurer'),
(8,'1991-01-01','1991-12-31','Secretary'),
(8,'1993-01-01','1993-12-31','Member'),
(8,'1994-01-01',null,'Member'),
(27,'1990-01-01', '1990-12-31','Member'),
(27,'1991-01-01','1991-12-31','Treasurer'),
(27,'1993-01-01', '1993-12-31', 'Treasurer'),
(57,'1992-01-01','1992-12-31','Secretary'),
(95,'1994-01-01',null,'Treasurer'),
(112,'1992-01-01','1992-12-31','Member'),
(112,'1994-01-01',null,'Secretary')
	  
	  