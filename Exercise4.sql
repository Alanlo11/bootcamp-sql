create database bootcamp_exercise4;

use bootcamp_exercise4;

create table players(
	player_id integer not null unique,
    group_id integer not null
);

create table matches(
	match_id integer not null unique,
    first_player integer not null,
    second_player integer not null,
    first_score integer not null,
    second_score integer not null
);

insert into players
(player_id,group_id) values
(20,2),
(30,1),
(40,3),
(45,1),
(50,2),
(65,1);

insert into matches
(match_id,first_player,second_player,first_score,second_score) values
(1,30,45,10,12),
(2,20,50,5,5),
(13,65,45,10,10),
(5,30,65,3,15),
(42,45,65,8,4);


select p.player_id, sum(m.first_score) as first_score
from players p inner join matches m on p.player_id = m.first_player
group by p.player_id;


select p.player_id, sum(m.second_score) as second_score
from players p inner join matches m on p.player_id = m.second_player
group by p.player_id;


select p.group_id, p.player_id as winner_id, sum(case when p.player_id = m.first_player then m.first_score else m.second_score end) as total_score
from players p 
left join matches m on p.player_id in(m.first_player,m.second_player)
group by p.group_id, p.player_id
order by total_score desc, winner_id asc;


select p.group_id, p.player_id as winner_id
from players p 
left join matches m on p.player_id in(m.first_player,m.second_player)
group by p.group_id, p.player_id
having max(sum(case when p.player_id = m.first_player then m.first_score else m.second_score end));


-- ans
with ranking as(
select p.group_id, p.player_id as winner_id, sum(case when p.player_id = m.first_player then m.first_score else m.second_score end) as total_score,
row_number() over(partition by p.group_id order by ifnull(sum(case when p.player_id = m.first_player then m.first_score else m.second_score end),0)desc,p.player_id asc) as ranking
from players p 
left join matches m on p.player_id in(m.first_player,m.second_player)
group by p.group_id, p.player_id
order by total_score desc, winner_id asc
)

select group_id, winner_id
from ranking
where ranking = 1;