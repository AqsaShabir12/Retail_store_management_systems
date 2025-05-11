create database if not exists sql_store2;
use sql_store2;
drop table if exists customers;
create table customers(
customer_id int primary key auto_increment,
first_name varchar(50) not null,
points int not null,
email varchar(100) not null unique);

alter table customers
 add points int not null default 0 after last_name ,
 add state char(2) not null,
 modify first_name varchar(55) default '',
drop points;

create table orders(
order_id int primary key,
customer_id int not null,
foreign key fk_orders_customers(customer_id)
references customers (customer_id) on update cascade on delete no action);