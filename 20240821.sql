-- comment
-- database -> table (row x column)
create database db_bc2405p;

-- login
use db_bc2405p;

-- Table name is per database
create table customers(
	id int,
    name varchar(50),
    email varchar(50)
);

-- inset into table_name (column1_name, ...) values (column1_value, ...);
insert into customers(id, name, email) values (1,'John Lau', 'john@gmail.com');
insert into customers(id, name, email) values (2,'Peter Wong', 'peter@gmail.com');
insert into customers values (10,'Lok man','lok@hotmail.com');
select * from customers;

-- * means all columns
-- "where" means conditions on columns
select * from customers;
select * from customers where id = 2;
select * from customers where id = 1 or id = 2;
select * from customers where id = 1 and id = 2; -- no data matches this criteria
select name, email from customers where id = 1; -- John, john@gmail.com

-- order by
select * from customers order by id ;-- asc , by default is asc -> 1 - 10
select * from customers order by id desc; --  -> 10 - 1

-- where (filter), order by (sort)
select * from customers where id = 1 order by id asc;
select * from customers where id = 1 order by id desc;

-- select * from customers where tran_date between '2024-08-21:09:00:00' and '2024-08-21:12:00:00';


create table students (
	id integer, -- int
    name varchar(20),
    weight numeric(5,2), -- 5-2(integer),2 dp(decimal place) 姐係3個位同2個位
    height numeric(5,2)
);

insert into students (id, name, weight, height) values (1, 'John', 68.23, 170);
insert into students (id, name, weight, height) values (4, 50, 68.23, 170);
insert into students (id, name, height) values (2, 'Mary', 155);
insert into students (id, weight) values (2, 43.5);
insert into students (id, weight) values (2.5, 45.5);
insert into students (id, weight) values (3, 40.5455); -- 會4捨5入
select * from students;

-- create table -> datetime, integer, numeric(10,2), varchar(50)

-- you can skip some column(s) when you execute insert statement
-- 要有statement，就可以唔入某d column
insert into students (id, name, weight) values (1, 'Benny Wong', 68.83);
select * from students;

-- If you don't specify the columns name, then you have to put all column values
-- 唔指定column，就要入晒全部colums values
insert into students values (8, 'Steven', null, 174.3);

-- DDL (Data Definition Language): create/drop table, add/drop column, modify column defintion
-- DML (Data Manipulation Language): insert row, update column, delete row, truncate (remove all data)

-- +, -, *, /, %
select weight + height as ABC,weight,id,name from students;
select s.weight + s.height as DEF,s.* from students s where s.weight > 65.5 order by name;

-- >, <, >=, <=, != <>, =
select * from students where id <> 6 and id <>8;
-- not in()
select * from students where id not in(1,2,3);
select * from students where id in (1,2,3);

-- like, not like
select * from students where name = 'John Wong';
select * from students where name like '%wong%'; -- Any name with prefix (0 or moew characters) and suffix (0 or more character);
select * from students where name like '%wong'; -- end with Wong

select * from students where name not like '%Wong';

-- Null check
select * from students where weight is null or height is null;

-- Functions
select char_length(s.name) as name_char_length, length(s.name), s.* from students s;
insert into students (id, name, weight, height) values (9, '張小強', 68.55, 180.5);

-- substring() -> start from 1
-- substring() 1,3 指1－3既字
-- replace() columns name -> change words -> 指定既字
select upper(s.name), lower(s.name),substring(s.name,1,3),trim(s.name),replace(s.name, 'Wong', 'Chan'), s.* from students s;

-- Java: indexOf(), DB: instr() return position
-- position starts from 1
-- If not found, return 0
-- instr 係指定格數，指定字，return指定字既第一個位
select instr(s.name,'Wong'), s.* from students s;

create table orders(
	id integer,
    total_amount numeric(10,2),
    customer_id integer
);

select * from orders; -- List<Order>
insert into orders values(1,2005.10,2);
insert into orders values(2,10000.9,2);
insert into orders values(3,99.9,3);

-- sum()
-- 3ms (without network consideration)
select sum(o.total_amount) from orders o;
select avg(o.total_amount) from orders o; -- over all avg
select avg(o.total_amount) from orders o where customer_id = 2; -- customer_id = 2 -> avg

-- filter first, and then min(), max()
select min(o.total_amount), max(o.total_amount) from orders o where customer_id = 2;

select o.*, 1 as number, 'hello' as string from orders o

select min(o.total_amount), max(o.total_amount)as max_amount,sum(o.total_amount),avg(o.total_amount) as avg_amount from orders o where customer_id = 2;

-- why can we put all functions in select statement
-- Ans: Aggregation Functions -> result must be 1 row
select min(o.total_amount), max(o.total_amount)as max_amount,sum(o.total_amount),avg(o.total_amount) as avg_amount, count(o.total_amount) from orders o where customer_id = 2;

-- o.total_amount -> NOT an aggregate result
-- 重點
select o.total_amount, sum(o.total._amount) from orders o; -- error
select o.total_amount, max(o.total_amount) from orders o; -- error

-- group by
select * from orders

-- group by -> select "group key" and agg functions
-- o.* -> group information or individual data information?
select o.customer_id, sum(o.total_amount),avg(o.total_amount),min(o.total_amount), max(o.total_amount),count(1)
from orders o group by o.customer_id

-- group by "unique key" -> meaningless
select o.id, sum(o.total_amount) from orders o group by o.id

-- GROUP BY + HAVING
insert into orders values (4, 10000.9, 3);
insert into orders values (5, 20000, 3);

select o.customer_id, avg(o.total_amount) as avg_amount
from orders o
where o.customer_id in (2,3) -- first filter before group by (5 row -> 4 rows) result: 4 rows x 3 columns
group by o.customer_id -- result: 2 row x 2 columns
having avg(o.total_amount) > 10000 -- another filter after group by (result): 1 row x 2 columns
;


-- 2 table (one to many)
-- where, group by, having, order by

-- example author, books


select * from customers where name = 'JOHN LAU'; -- case insenstive, 唔洗理大細階
select * from customers where UPPER(name) = 'JOHN LAU'; -- if case senstive, we should use upper() or lower()


select * from customers where name like '%HN%';
select * from customers where name like 'JO%LAU'; -- start with JO, end with LAU

select * from customers where name like '_ohn%';-- _ 係指定只有一個字, %係任意長度/字

select ROUND(o.total_amount, 0), o.* from orders o; -- round係會4捨5入,後面個數字係小數後幾多個位

select ceil(o.total_amount), floor(o.total_amount), ROUND(o.total_amount, 0), o.* from orders o;

select POWER(2, 3.5) AS result from dual; -- 11.313, from dual係可以唔洗call table

select 1, ABS(-5) from dual; -- 換做正數

-- Date formatting (MYSQL)
select DATE_FORMAT('2023-08-31', '%Y-%m-%d') from dual;
select DATE_FORMAT('2023-08-31', '%Y-%m-%d') + interval 1 day from dual; -- +1 day
select str_to_date('2023-12-31', '%Y-%m-%d') + interval 1 day from dual;

-- Oracle
select to_date('20240831', 'YYYYMMDD') + 1 from dual;-- +1 day

-- Extract Year or Month or Day (MySQL)
select extract(year from DATE_FORMAT('2023-08-31', '%y-%m-%d')) from dual;
select extract(month from DATE_FORMAT('2023-08-31', '%Y-%m-%d')) from dual;
select extract(day from DATE_FORMAT('2023/08/31', '%Y/%m/%d')) from dual;

-- Result:
-- 2024 2
-- 2023 2
-- 2022 1

select extract(year from tran_date), count(1) as number_of_orders
from orders
group by extract(year from tran_date)
having count(1) >= 2;


select * from orders;
alter table orders add column tran_date date; -- DDL

update orders 
set tran_date = date_format('2024-08-31', '%Y-%m-%d') 
where id = 1;
 
 update orders
 set tran_date = date_format('2024-08-02', '%Y-%m-%d')
 where id = 2;
 
 update orders
 set tran_date = date_format('2023-12-04', '%Y-%m-%d')
 where id = 3;
 
 update orders
 set tran_date = date_format('2024-02-28', '%Y-%m-%d')
 where id = 4;
 
 update orders
 set tran_date = date_format('2024-08-31', '%Y-%m-%d')
 where id = 5;

-- coalesce doesn't update the original data
select ifnull(s.weight, 'N/A'),ifnull(s.height, 'N/A'), s.* from students s;
select coalesce(s.weight, 'N/A'),coalesce(s.height, 'N/A'), s.* from students s;

-- < 2000 'S'
-- >=2000 and < 10000 'M'
-- >=10000 'L'

select CASE
	when o.total_amount < 1000 then 'S'
    when o.total_amount >= 2000 and o.total_amount < 10000 then 'M'
    else 'L'
    end as category
    , o.*
from orders o;


select CASE
	when o.total_amount < 1000 then 'S'
    when o.total_amount between 2000 and 10000 then 'M'
    else 'L'
    end as category
    , o.*
from orders o;

-- between (inclusive)
select * from orders where tran_date between date_format('2022-06-01', '%y-%m-%d')
and date_format('2022-12-04', '%y-%m-%d');

-- exists (customers, orders)
-- Find the customer(s) who has orders

insert into customers values (3, 'Jenny Yu', 'jenny@hotmail.com');
insert into customers values (4, 'Benny Kwok', 'benny@hotmail.com');
select * from customers;
select * from orders;

-- o.customer_id = c.id -> check if the customer exists in orders
-- Approach 1 (you cannot select columns from order table)
select *
from customers c
where exists (select 1 from orders o where o.customer_id = c.id);

-- Join tables
-- 4 customers x 9 orders
select *
from customers c inner join orders o; -- on

-- with conditions 9 rows
-- inner join similar to exists
-- Approach 2 
select c.id, c.name, o.total_amount, o.tran_date
from customers c inner join orders o on o.customer_id = c.id;

select * from customers;
select * from orders;

select *
from customers c
where not exists (select 1 from orders o where o.customer_id = c.id);

-- '2024-08' 5

insert into orders values (6, 9999, 3, date_format('2024-08-04', '%y-%m-%d'));
select concat_ws ('-', extract(year from tran_date), extract(month from tran_date)), o.* from orders o;

-- distinct delete dupicate value, distinct 2 column
select distinct concat_ws('-', extract(year from tran_date), extract(month from tran_date)) from orders;

-- distinct 2 columns
select distinct concat_ws('-', extract(year from tran_date), extract(month from tran_date)), total_amount from orders;

select * from orders

select o.*, (select max(total_amount) from orders)
from orders o

-- Subquery
-- First SQL to execute: select id from customers where name like '%lau'
-- Secondly, DBMS executes "select * from orders where customer_id in..."
select * from orders
where customer_id in (select id from customers where name like '%lau');

select * from orders;

insert into orders values (7, 400, null, date_format('2023-08-31', '%Y-%m-%d'));

-- Left join
select c.*, o.*
from customers c left join orders o on c.id = o.customer_id

select c.*, o.*
from orders o left join customers c on o.customer_id = c.id

-- Right join
-- 以右邊table為依歸，只係left join相反
select c.*, o.*
from customers c right join orders o on c.id = o.customer_id

-- Left join + Group by
-- count(o.id) is different to count(c.id)
-- Step 1: Left join (key)
-- Step 2: Where
-- Step 3: Group by
-- Step 4: Order by
-- Step 5: Select -> count(), max(), ifnull()
select c.id, c.name, count(o.id) number_of_orders, ifnull (max(total_amount), 0)  as max_amount_of_orders
from customers c left join orders o on c.id = o.customer_id 
where (o.total_amount > 100.0 or o.total_amount is null)
group by c.id, c.name
order by c.name asc;

select * from customers;
insert into customers values (5, 'Mary Chan', 'mary@gmail.com');
delete from customers where name is null;

-- Add PK (primary key)
-- id 唔可以重覆, use primary key(...)
alter table customers add constraint pk_customer_id primary key(id);

-- Duplicate value for PK
insert into customers values (4, 'Mary Chan', 'mary@gmail.com');-- error
insert into customers values (5, 'Mary Chan', 'mary@gmail.com');-- OK

-- Add FK
alter table orders add constraint fk_customer_id foreign key(customer_id) references customers(id)

select * from orders
insert into orders values (8, 9000, 10, date_format('2024-08-04', '%y-%m-%d'))
-- NOT ok, we do not have customer_id 10
insert into orders values (8, 9000, 5, date_format('2024-08-04', '%y-%m-%d'))
-- ok, we have customer_id 5

select * from customers
select * from orders

-- Table design: PK & FK ensures data is insert/ updated with integrity & consistency
-- Data -> integrity, consistency
-- Primary Key and foreign key are also a type of constriants
-- Every table has one PK only, but may be more than one FK.

-- Other Constriants: Unique Constriant
select * from customers
alter table customers add constraint unique_emial unique (email)
insert into customers values(6, null, 'john123@gmail.com') -- error

select * from customers

-- 之後加返個name唔可以null
-- Not Null (one or more columns can be "NOT NULL")
alter table customers modify name varchar(50) not null;

select * from customers;

-- union 係數據相加,要相同columns -> distinct
select name, email 
from customers
union
select id, total_amount
from orders;

-- Combine tow result set, no matter any duplicated
select 1
from customers
union all
select 1
from orders;








