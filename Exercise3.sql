create database bootcamp_exercise3;

use bootcamp_exercise3;

create table customer(
	id int primary key,
    customer_name varchar(255),
    city_id int,
    customer_address varchar(255),
    contact_person varchar(255) null,
    email varchar(128),
    phone varchar(128)
);

create table product(
	id int primary key,
    sku varchar(32),
    product_name varchar(128),
    product_description text,
    current_price decimal(8,2),
    quantity_in_stock int
);

create table invoice(
	id int primary key,
    invoice_number varchar(255),
    customer_id int,
    user_account_id int,
    total_price decimal(8,2),
    time_issued varchar(128) null,
    time_due varchar(128) null,
    time_paid varchar(128) null,
    time_canceled varchar(128) null,
    time_refunded varchar(128) null,
    foreign key (customer_id) references customer (id)
);

create table invoice_item(
	id int primary key,
    invoice_id int,
    product_id int,
    quantity int,
    price decimal(8,2),
    line_total_price decimal(8,2),
    foreign key (invoice_id) references invoice(id),
    foreign key (product_id) references product(id)
);

insert into customer
(id,customer_name,city_id,customer_address,contact_person,email,phone) values
(1,'Drogerie Wien',1,'Deckergasse 15A','Emil Steinbach','emil@drogeriewien.com',094234234),
(2,'Cosmetics Store',4,'Watling Street 347','Jeremy Corbyn','jermy@c-store.org',093923923),
(3,'Kosmetikstudio',3,'Rothenbaumchaussee 53','Willy Brandt','willy@kosmetistudio.com',0941562222),
(4,'Neue Kosmetik',1,'Karlsplatz 2',null,'info@neuekosmetik.com',094109253),
(5,'Bio Kosmetik',2,'Motzstrabe 204','Clara Zetkin','clara@biokosmetik.org',093825825),
(6,'K-Wien',1,'Karntner Strabe 204','Maria Rauch-Kallat','maria@kwien.org',093427002),
(7,'Natural Cosmetics',4,'Clerkenwell Road 14B','Glenda Jackson','glena.j@natural-cosmetics.com',093555123),
(8,'Kosmetik Plus',2,'Unter den Linden 1','Angela Merkel','angela@k-plus.com',094727727),
(9,'New Line Cosmetics',4,'Devonshire Street 92','Oliver Cromwell','oliver@nlc.org',093202404);


insert into product
(id,sku,product_name,product_description,current_price,quantity_in_stock) values
(1,330120,'Game Of Thrones-URBAN DECAY','Game Of Thrones Eyeshadow Palette',65,122),
(2,330121,'Advanced Night Repair - ESTEE LAUDER','Advanced Night Repair Synchronized Recovery Complex II',98,51),
(3,330122,'Rose Deep Hydration - FRESH','Rose Deep Hydration Facial Toner',45,34),
(4,330123,'Pore-Perfecting Moisturizer - TATCHA','Pore-Perfecting Moisturizer & Cleanser Duo',25,393),
(5,330124,'Capture Youth - DIOR','Capture Youth Serum Collection',95,74),
(6,330125,'Slice of Glow - GLOW RECIPE','Slice of Glow Set',45,40),
(7,330126,'Healthy Skin - KIEHL S SINCE 1851','Healthy Skin Squad',68,154),
(8,330127,'Power Pair! - IT COSMETICS','IT is Your Skincare Power Pair! Best-Selling Moisturizer & Eye Cream Duo',80,0),
(9,330128,'Dewy Skin Mist - TATCHA','Limited Edition Dewy Skin Mist Mini',20,281),
(10,330129,'Silk Pillowcase - SLIP','Silk Pillowcase Duo + Scrunchies Kit',170,0);

insert into invoice
(id,invoice_number,customer_id,user_account_id,total_price,time_issued,time_due,time_paid,time_canceled,time_refunded) values
(1,'in_25181b07ba800c8d2fc967fe991807d9',7,4,1436,'7/20/2019 3:05:05 PM','7/27/2019 3:05:05 PM','7/25/2019 9:24:12 AM',null,null),
(2,'8fba0000fd456b27502b9f81e9d52481',9,2,1000,'7/20/2019 3:07:11 PM','7/27/2019 3:07:11 PM','7/20/2019 3:10:32 PM',null,null),
(3,'3b6638118246b6bcfc3dfcd9be487599',3,2,360,'7/20/2019 3:06:15 PM','7/27/2019 3:06:15 PM','7/31/2019 9:22:11 PM',null,null),
(4,'def7f0a01a682196cac0120a9adbb550',5,2,1675,'7/20/2019 3:06:34 PM','7/27/2019 3:06:34 PM',null,null,null),
(5,'2a24cc2ad4440d698878a0a1a71f70fa',6,2,9500,'7/20/2019 3:06:42 PM','7/27/2019 3:06:42 PM',null,'7/22/2019 11:17:02 AM',null),
(6,'cbd304872ca6257716bcab8fc43204d7',4,2,150,'7/20/2019 3:08:15 PM','7/27/2019 3:08:15 PM','7/27/2019 1:42:45 PM',null,'7/27/2019 2:11:20 PM');

insert into invoice_item
(id,invoice_id,product_id,quantity,price,line_total_price) values
(1,1,1,20,65,1300),
(2,1,7,2,68,136),
(3,2,5,10,100,1000),
(4,3,10,2,180,360),
(5,4,1,5,65,325),
(6,4,2,10,95,950),
(7,4,5,4,100,400),
(8,5,10,100,95,9500),
(9,6,4,6,25,150);

select c.id, c.customer_name as customer_without_invoice
from customer c
where not exists(select 1 from invoice i where i.customer_id = c.id);

select p.id, p.product_name as product_not_sold
from product p
where not exists(select 1 from invoice_item i where i.product_id = p.id);


create table employee(
	id integer not null auto_increment primary key,
    employee_name varchar(30) not null,
    salary numeric(8,2),
    phone numeric(15),
    email varchar(50),
    dept_id integer not null
);

create table department(
	id integer not null auto_increment primary key,
    dept_code varchar(3) not null,
    dept_name varchar(200) not null
);

insert into employee
(employee_name,salary,phone,email,dept_id) values
('John',20000,90234567,'john@gmail.com',1),
('Mary',10000,90234561,'mary@gmail.com',1),
('Steven',30000,90234562,'steven@gmail.com',3),
('Sunny',40000,90234563,'sunny@gmail.com',4);

insert into department
(dept_code,dept_name) values
('HR','Human Resources'),
('9UP','9UP Department'),
('SA','Sales Department'),
('IT','Information Technology Department');

select d.dept_code, count(e.dept_id) as number_of_employees
from department d left join employee e on d.id = e.dept_id
group by d.dept_code
order by count(e.dept_id) desc,d.dept_code asc;

insert into department
(dept_code,dept_name) values
('IT','Information Technology Department');

-- 可以順利insert deplicated value,因為create table時冇將dept_code set做unique
-- 解決方法： alter table
alter table department add constraint unique_dept_code unique (dept_code);







