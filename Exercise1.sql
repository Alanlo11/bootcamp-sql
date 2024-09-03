create database bootcamp_exercise1;

use bootcamp_exercise1;

-- -----------------------------------------------------------------------------------------------------------------------------------------

create table regions(
	region_id int primary key,
    region_name varchar(25)
);

create table countries(
	country_id char(2) primary key,
    country_name varchar(40),
    region_id int,
	foreign key (region_id) references regions(region_id)
);

create table locations(
	location_id int primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12),
    country_id char(2),
    foreign key (country_id) references countries(country_id)
);

create table departments(
	department_id int primary key,
    department_name varchar(30),
    manager_id int,
    location_id int,
    foreign key (location_id) references locations(location_id)
);

create table jobs(
	job_id varchar(10) primary key,
    job_title varchar(35),
    min_salary int,
    max_salary int
);

create table employees(
	employee_id int primary key,
    first_name varchar(20),
    last_name varchar(25),
    email varchar(25),
    phone_number varchar(20),
    hire_date date,
    job_id varchar(10),
    salary int,
    commission_pct int,
    manager_id int,
    department_id int,
    foreign key (job_id) references jobs(job_id),
    foreign key (department_id) references departments(department_id)
);

create table job_history(
	employee_id int,
    start_date date not null,
    end_date date,
    job_id varchar(10),
    department_id int,
    foreign key (employee_id) references employees(employee_id),
    primary key (employee_id , start_date),
    foreign key (job_id) references jobs(job_id),
    foreign key (department_id) references departments(department_id)
);

-- -----------------------------------------------------------------------------------------------------------------------------------------

insert into regions values (1, 'Germany');
insert into regions values (2, 'Italy');
insert into regions values (3, 'United State');
insert into regions values (4, 'Japan');

insert into countries values ('DE','Germany','1');
insert into countries values ('IT','Italy','2');
insert into countries values ('US','United State','3');
insert into countries values ('JP','Japan','4');

insert into locations values (1000,'1297 Via Cola di Rie',989,'Roma', '' , 'IT');
insert into locations values (1100,'93091 Calle della Te',10934,'Venice', '' , 'IT');
insert into locations values (1200,'2017 Shinjuku-ku',1689,'Tokyo', 'Tokyo' , 'JP');
insert into locations values (1400,'2014 Jabberwocky Rd',26192,'Southlake', 'Texas' , 'US');

insert into departments values (10,'Administration',200,1100);
insert into departments values (20,'Marketing',201,1200);
insert into departments values (30,'Purchasing',202,1400);

insert into jobs values ('IT_PROG','IT Programmer',10000,30000);
insert into jobs values ('MK_REP','Marketing',11000,31000);
insert into jobs values ('ST_CLERK','Clerk',12000,32000);

insert into employees values (100,'Steven','King','SKING','515-1234567',date_format('1987-06-17', '%y-%m-%d'),'ST_CLERK',24000.00,0.00,109,10);
insert into employees values (101,'Neena','Kochhar','NKOCHHAR','515-1234568',date_format('1987-06-18', '%y-%m-%d'),'MK_REP',17000.00,0.00,103,20);
insert into employees values (102,'Lex','De Haan','LDEHAAN','515-1234569',date_format('1987-06-19', '%y-%m-%d'),'IT_PROG',17000.00,0.00,108,30);
insert into employees values (103,'Alexander','Hunold','AHUNOLD','590-4234567',date_format('1987-06-20', '%y-%m-%d'),'MK_REP',9000.00,0.00,105,20);

insert into job_history values (102,date_format('1993-01-13','%y-%m-%d'),date_format('1993-07-24','%y-%m-%d'),'IT_PROG',20);
insert into job_history values (101,date_format('1989-09-21','%y-%m-%d'),date_format('1993-10-27','%y-%m-%d'),'MK_REP',10);
insert into job_history values (101,date_format('1993-10-28','%y-%m-%d'),date_format('1997-03-15','%y-%m-%d'),'MK_REP',30);
insert into job_history values (100,date_format('1996-02-17','%y-%m-%d'),date_format('1999-12-19','%y-%m-%d'),'ST_CLERK',30);
insert into job_history values (103,date_format('1998-03-24','%y-%m-%d'),date_format('1999-12-31','%y-%m-%d'),'MK_REP',20);

-- -----------------------------------------------------------------------------------------------------------------------------------------

select l.location_id, l.street_address, l.city, l.state_province, c.country_name 
from locations l, countries c
where l.country_id = c.country_id;

select e.first_name, e.last_name, e.department_id
from employees e;

select e.first_name, e.last_name, e.job_id, e.department_id
from employees e inner join departments d on e.department_id = d.department_id
inner join locations l on d.location_id = l.location_id
inner join countries c on l.country_id = c.country_id
where c.country_name = 'Japan';

select e.employee_id, e.last_name, manager_id, last_name
from employees e 


create table job_grades(
	grade_level varchar(2) primary key,
    lowest_sal int,
    highest_sal int
);



