-- PART 3: ASSIGNMENT

-- Question 1
select initials as firstname,surname as lastname,
coalesce(leagueno,1) as leagueno from players 
where town='Stratford';

-- Question 2
select playerno,birth_date,to_char(birth_date,'day') as born_day,birth_date+7 as incremented_date 
from players 
where date_part('dow',birth_date)=6;

-- Question 3 
select paymentno,to_char(payment_date,'day') as payment_day 
from penalties 
where date_part('dow',payment_date)=1;

-- Question 4
select playerno,count(playerno) as no_of_penalties from penalties 
where amount > 25 
group by playerno
having count(playerno) >= 2
order by playerno; 

-- Question 5
select paymentno,t1.playerno,joined as joining_year,payment_date from players t1 
join penalties t2 
on t1.playerno=t2.playerno
and date_part('year',t2.payment_date)=t1.joined;

-- Question 6
select playerno,surname from players 
where town = (select town from players where playerno=27) 
and playerno <> 27; 

--Question 7 
select t1.playerno,surname,t2.total_penalty_amount from players t1, 
(select playerno,sum(amount) as total_penalty_amount from players left outer join penalties using (playerno) group by playerno) t2
where t1.playerno=t2.playerno
order by playerno;

-- Question 8
select playerno,initials,surname from players 
where playerno not in (select playerno from teams);

-- Question 9 
select teamno,count(teamno) as no_of_matches from matches 
where teamno = (select teamno from teams t join players p on t.playerno=p.playerno and p.town='Eltham')
group by teamno; 

-- Question 10
select playerno,sum(amount) as total_penalty 
from penalties 
group by playerno 
order by 2 desc limit 1;

-- Question 11
create or replace procedure remove_matches(p_playerno players.playerno%type)
language plpgsql
as
$$
declare
	v_playerno players.playerno%type;
begin
	-- checking if player exists or not 
	select playerno into strict v_playerno from players where playerno=p_playerno;
	
	-- deleting player
	delete from matches where playerno=p_playerno;
exception
	when NO_DATA_FOUND then raise exception 'Player does not exist';
	when others then raise exception 'Other exception';
end;
$$

-- call remove_matches(6);

-- Question 12
create or replace procedure show_penalty_total(p_playerno penalties.playerno%type)
language plpgsql
as 
$$
declare
 v_penalty_total penalties.amount%type;
 v_playerno penalties.playerno%type;
begin
  select playerno,sum(amount) into strict v_playerno,v_penalty_total from penalties where playerno=p_playerno group by playerno;
  raise notice 'Total penalty amount for playerno % = %',v_playerno,v_penalty_total;
exception
	when NO_DATA_FOUND then raise exception 'No penalty found for this player number';
	when others then raise exception 'Other exception';
end;
$$

-- call show_penalty_total(44);

-- Question 13
create or replace procedure show_address(p_playerno players.playerno%type)
language plpgsql
as 
$$
declare
	rec record;
begin
	select street,houseno,postcode,town into strict rec from players where playerno=p_playerno;
	raise notice '| playerno = % | street = % | houseno = % | postcode = % | town = % |',p_playerno,rec.street,rec.houseno,rec.postcode,rec.town;
exception
	when NO_DATA_FOUND then raise exception 'Player does not exist';
	when others then raise exception 'Other exception';
end;
$$

-- call show_address(44);

-- Question 14
create or replace procedure remove_player(p_playerno players.playerno%type)
language plpgsql 
as 
$$
declare 
  v_playerno players.playerno%type;
  v_pno_of_captain players.playerno%type;
  v_pno_with_penalty players.playerno%type;
begin
	-- checking if player exists 
	select playerno into strict v_playerno from players where playerno=p_playerno;
	
	-- checking if player is not a captain
	select t1.playerno into v_pno_of_captain from players t1 join teams t2 on t1.playerno=t2.playerno and t2.playerno=p_playerno;
	if not found then 
		-- checking if the player has a penalty against him
		select t1.playerno into v_pno_with_penalty from players t1 join penalties t2 on t1.playerno=t2.playerno and t2.playerno=p_playerno;
		if not found then 
			raise notice 'player can be removed';
			delete from players where playerno=p_playerno;
		else
			raise exception 'player has penalty against him, hence cannot be removed';
		end if;
	else 
		raise exception 'player is a captain, hence cannot be removed';
	end if;
		
exception
	when NO_DATA_FOUND then raise exception 'Player does not exist';
end;
$$

-- call remove_player(27);

-- Question 15

-- function for calculating no. of penalties for a given player
create or replace function no_of_penalties(p_playerno players.playerno%type) returns int
language plpgsql
as 
$$
declare
	v_playerno players.playerno%type;
	total_penalties int;
begin
	-- checking if players exists or not
	select playerno into strict v_playerno from players where playerno=p_playerno;

	-- finding no. of penalties
	select count(playerno) into strict total_penalties from penalties where playerno=p_playerno;
    return total_penalties;
exception 
	when NO_DATA_FOUND then raise exception 'Player does not exist';
	when others then raise exception 'Other exception';
end;
$$

-- function for calculating no. of matches played by a given player
create or replace function no_of_matches(p_playerno players.playerno%type) returns int
language plpgsql
as
$$
declare
	v_playerno players.playerno%type;
	total_matches int;
begin
	-- checking if players exists or not
	select playerno into strict v_playerno from players where playerno=p_playerno;

	-- finding no. of matches played
	select count(playerno) into total_matches from matches where playerno=p_playerno;
	return total_matches;
exception 
	when NO_DATA_FOUND then raise exception 'Player does not exist';
	when others then raise exception 'Other exception';
end;
$$

select playerno,initials,surname from players 
where playerno 
in (select playerno from players where no_of_penalties(playerno) > no_of_matches(playerno));


