create database bootcamp_exercise2;

use bootcamp_exercise2;

create table worker(
	worker_id integer not null primary key auto_increment,
    first_name char(25),
    last_name char(25),
    salary numeric(15),
    joining_date datetime,
    department char(25)
);

insert into worker 
(first_name, last_name, salary, joining_date, department) values 
('Monika', 'Arora', 100000, '2021-02-20 09:00:00', 'HR'),
('Nikarika', 'Verma', 80000, '2021-06-11 09:00:00', 'Admin'),
('Vishal', 'Singhal', 300000, '2021-02-20 09:00:00', 'HR'),
('Mohan', 'Sarah', 300000, '2012-03-19 09:00:00', 'Admin'),
('Amitabh', 'Singh', 500000, '2021-02-20 09:00:00', 'Admin'),
('Vivek', 'Bhati', 490000, '2021-06-11 09:00:00', 'Admin'),
('Vipul', 'Diwan', 200000, '2021-06-11 09:00:00', 'Account'),
('Satish', 'Kumar', 75000, '2021-01-20 09:00:00', 'Account'),
('Geetika', 'Chauhan', 90000, '2021-04-11 09:00:00', 'Admin');

create table bonus(
	worker_ref_id integer,
    bonus_amount numeric(10),
    bonus_date datetime,
    foreign key (worker_ref_id) references worker(worker_id)
);

-- Task 1:
insert into bonus (worker_ref_id, bonus_amount, bonus_date) values ((select worker_id from worker where first_name = 'Vivek') , 32000, '2021-11-02');
insert into bonus (worker_ref_id, bonus_amount, bonus_date) values ((select worker_id from worker where first_name = 'Vivek') , 20000, '2022-11-02');
insert into bonus (worker_ref_id, bonus_amount, bonus_date) values ((select worker_id from worker where first_name = 'Amitabh') , 21000, '2021-11-02');
insert into bonus (worker_ref_id, bonus_amount, bonus_date) values ((select worker_id from worker where first_name = 'Geetika') , 30000, '2021-11-02');
insert into bonus (worker_ref_id, bonus_amount, bonus_date) values ((select worker_id from worker where first_name = 'Satish') , 4500, '2022-11-02');

-- Task 2:
select w.salary
from worker w
order by w.salary desc
limit 1 offset 1;

-- Task 3:
select w.department, w.first_name, w.salary as highest_salary
from worker w
where w.salary = (select max(salary) from worker where department = w.department);

-- Task 4:
select w.first_name,o.first_name, w.salary
from worker w inner join worker o on w.salary = o.salary
where w.worker_id != o.worker_id;

-- Task 5:
select w.first_name, sum(w.salary + ifnull(b.bonus_amount,0)) as salary_bonus_in_2021
from worker w left join bonus b on w.worker_id = b.worker_ref_id and year(b.bonus_date) = 2021
group by w.first_name;

-- Task 6:
delete from worker;
-- 不能delete data係因為佢有foreign key係table bonus worker_id
-- 要先delete worker_id 呢個column/解除左foreign key就可以delete到data
select constraint_name
from information_schema.KEY_COLUMN_USAGE 
where table_name = 'bonus' and TABLE_SCHEMA = 'bootcamp_exercise2';

alter table bonus drop foreign key bonus_ibfk_1;

-- Task 7:
drop table worker;
-- 完成左Task 6後，已經解除左foreign key,所以可以直接delete
-- 否則就要先drop table
drop table bonus;
drop table worker;
