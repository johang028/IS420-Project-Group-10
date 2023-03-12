drop table restaurant cascade constraints;
drop sequence res_seq;

drop table category cascade constraints;
drop sequence cat_seq;

drop table dish cascade constraints;
drop sequence dish_seq;

drop table res_cat cascade constraints;

drop table salestax cascade constraints;
drop sequence seq_stid;

drop table review cascade constraints;
drop sequence seq_rvid;

drop table cart cascade constraints;
drop sequence seq_cart;

drop table cart_dish cascade constraints;

drop table itemOrder cascade constraints;
drop sequence seq_itemOrder;

drop table customer cascade constraints;
drop sequence seq_cid;

drop table dish_order cascade constraints;

drop table payment cascade constraints;
drop sequence pay_seq;

drop table message cascade constraints;
drop sequence mes_seq;

Drop table discount cascade constraints; 
Drop table discount_seq;

Drop table customer_discount cascade constraints; 

-- Table store customer information
create table customer (
	cid int not null,
	cname varchar2(255) not null,
	cadr varchar2(255),
	cstt varchar2(2),
	czip int(5),
	cemail varchar2(255),
	credit int(4,2),
	
	primary key (cid)
);

-- AutoSequence for Customer ID
create sequence seq_cid
minvalue 0
maxvalue 9999999
start with 1
increment by 1
cache 50;

--data for table customer
insert into customer 
	values (seq_cid.nextval, 'Wendi Robles', '202 W. Shore Ave', 'OH', 43612, 'rattha@problemstory.us', 0);
insert into customer 
	values (seq_cid.nextval, 'Darnell House', '7765 Taklin Hill Dr.', 'CA', 95301, 'fxllipek@mtcxmail.com', 350.00);
insert into customer
	values (seq_cid.nextval, 'Korey Booth', '67 Sycamore St', 'GA', 31021, 'tavaira@kientao.online', 200.00);
insert into customer
	values (seq_cid.nextval, 'Milly Jenkins', '13458 Centennial Lane', 'MD', 21042, 'milly@gmail.com', 15.00);
insert into customer
	values (seq_cid.nextval, 'Sam Houston', '4277 Winsor mills rd.', 'MD', 22442, 'sam@gmail.com', 1.00);
insert into customer
	values (seq_cid.nextval, 'Ben Franklin', '84 Milky way', 'MD', 21444, 'benf@gmail.com', 0);

-- Table to store review information
create table review (
	rvid int not null,
	cid int not null,
	rtid int not null,
	rvdate date not null,
	rvscr int(1,1) not null check (rvscr between 0.0 and 5.0),
	rvcmt varchar2(255),
	
	primary key (rvid)
);

-- AutoSequence for review ID
create sequence seq_rvid
minvalue 0
maxvalue 9999999
start with 1
increment by 1
cache 50;

--data for table review
insert into review
	values (seq_rvid.next, 1, 1, to_date('2023-02-02', 'yyyy-mm-dd'), 5.0, 'very good');
insert into review
	values (seq_rvid.next, 2, 2, to_date('2023-02-04', 'yyyy-mm-dd'), 4.0, 'It is okay');
insert into review
	values (seq_rvid.next, 1, 2, to_date('2023-02-02', 'yyyy-mm-dd'), 4.5, 'food is good, service is okay');
	
-- Table 2: discount
Create table discount (
did int,
discount_description varchar (200),
discount_type int,
primary key (did)
);

create sequence discount_seq
    minvalue 1
    increment by 1;

Insert into discounts (did, discount_description, discount_type) values
(discount_seq.nextval, 1, 'Free delivery', 1);
Insert into discounts (did, discount_description, discount_type) values
(discount_seq.nextval, 2, '10% off total charge', 2);
Insert into discounts (did, discount_description, discount_type) values
(discount_seq.nextval, 3, ‘'20% off total charge', 3);

-- Table 3: store sales tax information
create table salestax (
	stid int not null,
	ststt varchar2(2) not null,
	strt int(0,4) not null,
	
	primary key (stid)
);

-- AutoSequence for Sales Tax ID
create sequence seq_stid
minvalue 0
maxvalue 9999999
start with 1
increment by 1
cache 50;

--data for table customer
insert into salestax
	values (seq_stid.next, AK, 0.0000);
insert into salestax
	values (seq_stid.next, DC, 0.6000);
insert into salestax
	values (seq_stid.next, MD, 0.6000);
insert into salestax
	values (seq_stid.next, VA, 0.5300);
insert into salestax
	values (seq_stid.next, TX, 0.6250);
	
---Table 4 : Customer Discount
Create table customer_discount (
cid int not null,
did int not null,
discount_start_date date not null,
discount_end_date date not null,
Primary key (cid, did),
Foreign key (cid) References customer(cid),
Foreign key (did) References discount(did)
);
Insert into discounts (cid, did, discount_start_date, discount_end_date) values
(1,1, date '2023-02-12', date '2023-02-18');
Insert into discounts (cid, did, discount_start_date, discount_end_date) values
(1,1, date '2023-06-11', date '2023-06-17');
Insert into discounts (cid, did, discount_start_date, discount_end_date) values
(1,1, date '2023-01-09', date '2023-02-15');

--Table 6: Restaurant
create table restaurant(
    resid int,
    resname varchar(30),
    resphonenum varchar(10),
    resstatus varchar(6), --open or closed
    resaddress varchar(30),
    reszipcode varchar(10),
    resstate varchar(30),
    resavgwaittime int,
    resavgreviewscore int,
    primary key (resid)
);

create sequence res_seq
	minvalue 0
	maxvalue 9999999
	start with 1
	increment by 1
	cache 50;

insert into restaurant values(res_seq.nextval, 'Bobs Pizza', '4434568171', 'open', 
    '123 street', '46172', 'Maryland', null, null);
insert into restaurant values(res_seq.nextval, 'Timmy Tams', '4637263758', 'closed', 
    '123 ave', '74582', 'New York', null, null);
insert into restaurant values(res_seq.nextval, 'Burger Place', '7584726486', 'open', 
    '123 drive', '18374', 'Maine', null, null);

--Table 8: Dish
create table dish(
    dishid int,
    resid int,
    dishname varchar(30),
    dishprice int,
    primary key (dishid),
    foreign key (resid) references restaurant
);

create sequence dish_seq
	minvalue 0
	maxvalue 9999999
	start with 1
	increment by 1
	cache 50;

insert into dish values(dish_seq.nextval, 1, 'Pizza', 10);
insert into dish values(dish_seq.nextval, 2, 'Tams', 2);
insert into dish values(dish_seq.nextval, 3, 'Veggie Burger', 35);

--Table 5: Category
create table category(
    catid int,
    catname varchar(30),
    primary key (catid)
);

create sequence cat_seq
	minvalue 0
	maxvalue 9999999
	start with 1
	increment by 1
	cache 50;

insert into category values(cat_seq.nextval, 'Italian');
insert into category values(cat_seq.nextval, 'Fast Food');
insert into category values(cat_seq.nextval, 'American');

--Table 7: Restaurant_category
create table res_cat(
    catid int,
    resid int,
    primary key (catid, resid),
    foreign key (catid) references category,
    foreign key (resid) references restaurant
);

insert into res_cat values(1, 1);
insert into res_cat values(2, 2);
insert into res_cat values(3, 3);

--Table 10: Cart
create table cart(
cartid int,
cid int,
resid int,
primary key (cartid),
foreign key (cid) references customer,
foreign key (resid) references restaurant
);

create sequence seq_cart
minvalue 0
maxvalue 9999999
start with 1
increment by 1
cache 50;

insert into cart
values
(seq_cart.nextval, 1, 1);

insert into cart
values
(seq_cart.nextval, 1, 2);

insert into cart
values
(seq_cart.nextval, 2, 2);

--Table 11: Cart_dish
create table cart_dish(
cartid int,
resid int,
dishid int,
quantity int,
foreign key (cartid) references cart,
foreign key (resid) references restaurant,
foreign key (dishid) references dish
);

insert into cart_dish
values
(1, 1, 1, 10);

insert into cart_dish
values
(2, 2, 1, 5);

insert into cart_dish
values
(3, 2, 2, 15);

--Table 12: Order (named itemOrder since order is a keyword)
create table itemOrder(
orderid int,
cid int, 
resid int,
order_time timestamp,
delivery_time timestamp,
estimated_time timestamp,
status int,
payment_status int, 
total_cost decimal, 
delivery_method int,
primary key (orderid),
foreign key (cid) references customer,
foreign key (resid) references restaurant, 
constraint check_order_delivery_method check(delivery_method in (1, 2)),
constraint check_order_status check(status in (1, 2, 3))
);

create sequence seq_itemOrder
minvalue 0
maxvalue 9999999
start with 1
increment by 1
cache 50;

insert into itemOrder
values
(seq_itemOrder.nextval, 1, 1, timestamp '2023-3-12 09:00:30.75', 
timestamp '2023-3-12 09:30:30.75', timestamp '2023-3-12 09:20:30.75', 1, 1, 20.20, 1);

insert into itemOrder
values
(seq_itemOrder.nextval, 2, 2, timestamp '2023-3-12 10:00:30.75', 
null, timestamp '2023-3-12 10:15:30.75', 1, 2, 50.25, 2);

insert into itemOrder
values
(seq_itemOrder.nextval, 3, 2, timestamp '2023-3-12 12:15:30.75', 
null, null, 3, 2, 0, 2);

--Table 13: store dishes in an order, including order id and dish id
create table dish_order (
  oid      int,
  dishid       int,
  foreign key (oid) references itemOrder (oid),
  foreign key (dishd) references dish (dishid)
);

insert into dish_order values (do_seq.nextval,1);
insert into dish_order values (do_seq.nextval,2);
insert into dish_order values (do_seq.nextval,3);

--Table 14: payment table
create table payment (
  payid       int,
  oid         int,
  custid      int,
  pamount     number(5,2),
  method    varchar(255)
  check (status in ('Credit/Debit Card','Apple Pay','PayPal')) not null,
  primary key (payid),
  foreign key (oid) references itemOrder (oid),
  foreign key (custid) references customer (custid)
  );
  
create sequence pay_seq
	minvalue 0
	maxvalue 9999999
	start with 1
	increment by 1
	cache 50;

  insert into payment values (pay_seq.nextval,1,1,76.88,'Credit/Debit Card');
  insert into payment values (pay_seq.nextval,2,2,64.12,'Credit/Debit Card');
  insert into payment values (pay_seq.nextval,3,3,97.57,'Apple Pay');

--Table 15: message table
create table message (
  mesid        int,
  custid       int,
  mtime        date,
  mbody        varchar(255),
  primary key (mesid),
  foreign key (custid) references customer (custid)
);

create sequence mes_seq
	minvalue 0
	maxvalue 9999999
	start with 1
	increment by 1
	cache 50;

insert into message values (mes_seq.nextval,1, date '2023-1-28', 'Receipt concerns with previous visit to the restaurant');
insert into message values (mes_seq.nextval,2, date '2023-1-30', 'A personal message thanking the head chef.');
insert into message values (mes_seq.nextval,3, date '2023-2-15', 'Is this restaurant open on weekends?');

