-- comment
-- database -> table (row x column)
create database db_bc2405p;

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
select * from customers where id = 1 order by id desc;

-- select * from customers where tran_date between '2024-08-21:09:00:00' and '2024-08-21:12:00:00';


create table students (
	id integer, -- int
    name varchar(20),
    weight numeric(5,2), -- 5-2(integer),2 dp(decimal place)
    height numeric(5,2)
);

insert into students (id, name, weight, height) values (1, 'John', 68.23, 170);
insert into students (id, name, weight, height) values (4, 50, 68.23, 170);
insert into students (id, name, height) values (2, 'Mary', 155);
insert into students (id, weight) values (2, 43.5);
insert into students (id, weight) values (2.5, 45.5);
insert into students (id, weight) values (3, 40.5455); -- 會4捨5入
select * from students;

-- create table -> datetime, integer, numeric(10,2), varchar(10)





