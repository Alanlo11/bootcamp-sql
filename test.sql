create table orders2(
	orders_no integer,
    total_amount numeric(8,2),
    customer_id integer
);

use orders2;

insert into orders2 (orders_no, total_amount, customer_id) values (1, 3587.12, 1);
insert into orders2 (orders_no, total_amount, customer_id) values (2, 974.35, 2);
insert into orders2 (orders_no, total_amount, customer_id) values (3, 7892.74, 3);
insert into orders2 (orders_no, total_amount, customer_id) values (4, 2348.73, 1);
insert into orders2 (orders_no, total_amount, customer_id) values (5, 3598.48, 2);

select * from orders2 where customer_id = 2;

select o.customer_id, sum(o.total_amount) amount from orders2 o group by o.customer_id order by customer_id desc;

select o.customer_id, sum(o.total_amount) amount from orders2 o group by o.customer_id having sum(o.total_amount) > 6000;

select o.orders_no, o.total_amount, o.customer_id from orders2 o having o.total_amount > 3000;


