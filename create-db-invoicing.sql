DROP DATABASE IF EXISTS `invoicing`;
CREATE DATABASE `invoicing`; 
USE `invoicing`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `payment_methods` (
  `payment_method_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `payment_methods` VALUES (1,'Credit Card');
INSERT INTO `payment_methods` VALUES (2,'Cash');
INSERT INTO `payment_methods` VALUES (3,'PayPal');
INSERT INTO `payment_methods` VALUES (4,'Wire Transfer');

CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` char(2) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `clients` VALUES (1,'Vinte','3 Nevada Parkway','Syracuse','NY','315-252-7305');
INSERT INTO `clients` VALUES (2,'Myworks','34267 Glendale Parkway','Huntington','WV','304-659-1170');
INSERT INTO `clients` VALUES (3,'Yadel','096 Pawling Parkway','San Francisco','CA','415-144-6037');
INSERT INTO `clients` VALUES (4,'Kwideo','81674 Westerfield Circle','Waco','TX','254-750-0784');
INSERT INTO `clients` VALUES (5,'Topiclounge','0863 Farmco Road','Portland','OR','971-888-9129');

CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `number` varchar(50) NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_total` decimal(9,2) NOT NULL,
  `payment_total` decimal(9,2) NOT NULL DEFAULT '0.00',
  `invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_date` date DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `FK_client_id` (`client_id`),
  CONSTRAINT `FK_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `invoices` VALUES (1,'91-953-3396',2,101.79,0.00,'2019-03-09','2019-03-29',NULL);
INSERT INTO `invoices` VALUES (2,'03-898-6735',5,175.32,8.18,'2019-06-11','2019-07-01','2019-02-12');
INSERT INTO `invoices` VALUES (3,'20-228-0335',5,147.99,0.00,'2019-07-31','2019-08-20',NULL);
INSERT INTO `invoices` VALUES (4,'56-934-0748',3,152.21,0.00,'2019-03-08','2019-03-28',NULL);
INSERT INTO `invoices` VALUES (5,'87-052-3121',5,169.36,0.00,'2019-07-18','2019-08-07',NULL);
INSERT INTO `invoices` VALUES (6,'75-587-6626',1,157.78,74.55,'2019-01-29','2019-02-18','2019-01-03');
INSERT INTO `invoices` VALUES (7,'68-093-9863',3,133.87,0.00,'2019-09-04','2019-09-24',NULL);
INSERT INTO `invoices` VALUES (8,'78-145-1093',1,189.12,0.00,'2019-05-20','2019-06-09',NULL);
INSERT INTO `invoices` VALUES (9,'77-593-0081',5,172.17,0.00,'2019-07-09','2019-07-29',NULL);
INSERT INTO `invoices` VALUES (10,'48-266-1517',1,159.50,0.00,'2019-06-30','2019-07-20',NULL);
INSERT INTO `invoices` VALUES (11,'20-848-0181',3,126.15,0.03,'2019-01-07','2019-01-27','2019-01-11');
INSERT INTO `invoices` VALUES (13,'41-666-1035',5,135.01,87.44,'2019-06-25','2019-07-15','2019-01-26');
INSERT INTO `invoices` VALUES (15,'55-105-9605',3,167.29,80.31,'2019-11-25','2019-12-15','2019-01-15');
INSERT INTO `invoices` VALUES (16,'10-451-8824',1,162.02,0.00,'2019-03-30','2019-04-19',NULL);
INSERT INTO `invoices` VALUES (17,'33-615-4694',3,126.38,68.10,'2019-07-30','2019-08-19','2019-01-15');
INSERT INTO `invoices` VALUES (18,'52-269-9803',5,180.17,42.77,'2019-05-23','2019-06-12','2019-01-08');
INSERT INTO `invoices` VALUES (19,'83-559-4105',1,134.47,0.00,'2019-11-23','2019-12-13',NULL);

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `fk_client_id_idx` (`client_id`),
  KEY `fk_invoice_id_idx` (`invoice_id`),
  KEY `fk_payment_payment_method_idx` (`payment_method`),
  CONSTRAINT `fk_payment_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_payment_method` FOREIGN KEY (`payment_method`) REFERENCES `payment_methods` (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `payments` VALUES (1,5,2,'2019-02-12',8.18,1);
INSERT INTO `payments` VALUES (2,1,6,'2019-01-03',74.55,1);
INSERT INTO `payments` VALUES (3,3,11,'2019-01-11',0.03,1);
INSERT INTO `payments` VALUES (4,5,13,'2019-01-26',87.44,1);
INSERT INTO `payments` VALUES (5,3,15,'2019-01-15',80.31,1);
INSERT INTO `payments` VALUES (6,3,17,'2019-01-15',68.10,1);
INSERT INTO `payments` VALUES (7,5,18,'2019-01-08',32.77,1);
INSERT INTO `payments` VALUES (8,5,18,'2019-01-08',10.00,2);

select * from payments;
select *
from  payments p
join clients c using (client_id)
join payment_methods py 
	on py.payment_method_id = p.payment_method;
    
    
select p.date, c.name as client, p.amount, pm.name as name
from payments p
join clients c using (client_id)
join payment_methods pm on p.payment_method = pm.payment_method_id;

create table invoices_archive as
select *
from invoices;

SELECT * FROM invoicing.invoices;

insert into invoices_archive  
select i.invoice_id,
	   i.number,
       c.name as name,
       i.invoice_total, 
       i.payment_total, 
       i.invoice_date,
       i.due_date, 
       i.payment_date
from invoices i
join clients c using (client_id)
where payment_date is not null;

select 
'First Half of 2019' as date_range,
sum(invoice_total) as total_sales,
sum(payment_total) as total_payments,
sum(invoice_total - payment_total) as what_we_expect
from invoices
where invoice_date between '2019-01-01' and '2019-06-01'
union
select 
'Second Half of 2019' as date_range,
sum(invoice_total) as total_sales,
sum(payment_total) as total_payments,
sum(invoice_total - payment_total) as what_we_expect
from invoices
where invoice_date between '2019-07-01' and '2019-12-01'
union
select 
'Total' as date_range,
sum(invoice_total) as total_sales,
sum(payment_total) as total_payments,
sum(invoice_total - payment_total) as what_we_expect
from invoices
where invoice_date between '2019-01-01' and '2019-12-01';

select
p.date, pm.name,sum(amount)
from payments p
join payment_methods pm on p.payment_method = pm.payment_method_id
group by p.date,pm.name;

select pm.name,
sum(amount) as total
from payment_methods pm
join payments p on p.payment_method = pm.payment_method_id
group by pm.name with rollup;

select *
from clients
where client_id not in
(select distinct client_id
from invoices);

select invoice_id
from invoices i
where invoice_total > (
select avg(invoice_total)
from invoices
where invoices.client_id = i.client_id);

select
client_id,
name,
(select sum(invoice_total)
from invoices
where c.client_id = invoices.client_id) as total_sales,
(select avg(invoice_total)
from invoices) as total_avergae,
((select total_sales) - (select total_avergae)) as difference
from clients c;

create or replace view clients_balance as
select distinct i.client_id, c.name,
sum(payment_total - invoice_total) as balance
from invoices i
join clients c using (client_id)
group by i.client_id,c.name;

-- CREATING PROCEDURES
DELIMITER $$
create procedure get_invoices_with_balance()
begin
select invoice_id,number,client_id,invoice_total,payment_total,(invoice_total - payment_total) as balance,due_date,payment_date
from invoices
where invoice_total - payment_total > 0;
end $$
DELIMITER ;
CALL get_invoices_with_balance();

drop procedure if exists get_clients_with_state_by_default;
DELIMITER $$
create procedure get_clients_with_state_by_default (state char(2))
begin
	if state is null then
		set state = 'CA';  
	end if;
	select * from clients c
    where c.state = state;
end $$
DELIMITER ;

call get_clients_with_state (NULL);

drop procedure if exists get_invoices_by_client;
DELIMITER $$
create procedure get_invoices_by_client (client_id int)
begin
select invoice_id
from invoices i 
where i.client_id = client_id;
end$$
DELIMITER ;

call get_invoices_by_client (1);



drop procedure if exists get_paymentss;
DELIMITER $$
create procedure get_paymentss(client_id int, payment_method_id tinyint)
begin
if payment_method_id > 4 then -- checking validation of parameters
	signal sqlstate '22003'
    set message_text = 'Invalid value. Enter either 1,2,3,4 ';
end if;
select *
from payments p
join payment_methods pm on p.payment_method = pm.payment_method_id
where p.client_id = ifnull(client_id,p.client_id) -- this will represent the entire value on the table if its null
and pm.payment_method_id = ifnull(payment_method_id, pm.payment_method_id);
end $$
DELIMITER ;

call get_payments(1,2);

drop procedure if exists get_risk_factor;
DELIMITER $$
create procedure get_risk_factor(client_id int)
begin
	declare risk_factor decimal(9,2) default 0; -- for declaring the local variables
    declare invoices_total decimal (9,2);
    declare invoice_count int;
    
    select count(*),sum(invoice_total)
    into invoice_count,invoices_total -- for putting the values into the stored variables
    from invoices i;
    
    set risk_factor = invoices_total/invoice_count * 5;
    select risk_factor;
end$$
DELIMITER ;

drop function if exists get_risk_factor;

select client_id,
name,
get_risk_factor(client_id)
from clients;

DELIMITER $$
drop trigger if exists payments_after_delete;
create trigger payments_after_delete -- updating an entry of payment totla once an entry is deleted
	after delete on payments
    for each row
begin
	update invoices
    set payment_total = payment_total - old.amount
    where invoice_id = old.invoice_id;
    
    insert into payment_audits values -- updating the values in an auditing table to keep the check on the insertion and deletion by triggers
    (old.client_id,old.date,old.amount,'Delete',now());
end$$
DELIMITER ;

DELIMITER $$
drop trigger if exists payments_after_insert;
create trigger payments_after_insert -- updating an entry of payment totla once an entry is updated
	after insert on payments
    for each row
begin
	update invoices
    set payment_total = payment_total + new.amount
    where invoice_id = new.invoice_id;
    
    insert into payment_audits values
    (new.client_id,new.date,new.amount,'Insert',now());
end$$
DELIMITER ;

insert into payments values (default, 5, 3 , '2019-01-01', 10,1); -- changes in paymnets automatically updates the invoices table
delete from payments where payment_id = 10;

create table payment_audits( -- table is created to checking in the audit values 
client_id int not null,
date date not null,
amount decimal(9,2) not null,
action_type varchar(50) not null,
action_date datetime not null);

show triggers; --  for seeing triggers
DELIMITER $$
create procedure get_clients_by_state(state char(2))
begin
if state is null then 
set state = 'CA';
end if;
select *
from clients c
where c.state = state;
end $$
DELIMITER ;

call get_clients_by_state (NULL);