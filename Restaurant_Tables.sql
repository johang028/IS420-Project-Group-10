-- T01 Customer
-- T01.0: drop customer table and its pk sequence
drop table customer cascade constraints;
drop sequence seq_cid;

-- T01.1: create customer table
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

-- T01.2: create autosequence for CID
create sequence seq_cid
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T01.3: insert data to customer
insert into customer 
	values (1, 'Wendi Robles', '202 W. Shore Ave', 'OH', 43612, 'rattha@problemstory.us', 0);
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


-- T02 Discount
-- T02.0: drop discount table and its pk sequence
drop table discount cascade constraints;
drop sequence seq_did;

-- T02.1: create discount table
create table discount (
	did int not null,
	discount_description varchar2(255),
	discount_type int not null,

	primary key (did)
);

-- T02.2: create autosequence for DID
create sequence discount_seq
	minvalue 1
	increment by 1;
	cache 50;
	
-- T02.3: insert date to discount
Insert into discounts (did, discount_description, discount_type)
	values (1, 'Free delivery', 1);
Insert into discounts (did, discount_description, discount_type) 
	values (discount_seq.nextval, '10% off total charge', 2);
Insert into discounts (did, discount_description, discount_type) 
	values (discount_seq.nextval, '20% off total charge', 3);


-- T03 Sale Tax
-- T03.0: drop saletax table and its pk sequence
drop table salestax cascade constraints;
drop sequence seq_stid;

-- T03.1: create saletax table
create table salestax (
	stid int not null,
	ststt varchar2(2) not null,
	strt int(0,4) not null,
	
	primary key (stid)
);

-- T03.2: create sequence for STID
create sequence seq_stid
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T03.3: insert data to saletax
insert into salestax
	values (1, AK, 0.0000);
insert into salestax
	values (seq_stid.next, DC, 0.6000);
insert into salestax
	values (seq_stid.next, MD, 0.6000);
insert into salestax
	values (seq_stid.next, VA, 0.5300);
insert into salestax
	values (seq_stid.next, TX, 0.6250);
	

-- T04 Customer Discount
-- T04.0: drop customer_discount table and its pk sequence

-- T04.1: create customer_discount table
create table customer_discount (
	cid int not null,
	did int not null,
	discount_start_date date not null,
	discount_end_date date not null,

	primary key (cid, did),
	foreign key (cid) References customer(cid),
	foreign key (did) References discount(did)
);


-- T5.0: drop category table and its pk sequence
drop table category cascade constraints;
drop sequence cat_seq;

-- T5.1: create category table
create table category(
    catid int not null,
    catname varchar2(255),

    primary key (catid)
);

-- T5.2: create sequence for CATID
create sequence cat_seq
	minvalue 0
	maxvalue 9999999
	start with 1
	increment by 1
	cache 50;

-- T5.3: insert data to category
insert into category 
	values(1, 'Italian');
insert into category 
	values(cat_seq.nextval, 'Fast Food');
insert into category 
	values(cat_seq.nextval, 'American');
	

-- T06 Restaurant
-- T06.0: drop restaurant table and its pk sequence
drop table restaurant cascade constraints;
drop sequence res_seq;

-- T06.1: create restaurant table
create table restaurant(
	resid int not null,
	resname varchar2(255) not null,
	resphonenum varchar(10),
	resstatus varchar(6), --open or closed
	resaddress varchar(30),
	reszipcode varchar(10),
	resstate varchar(30),
	resavgwaittime int,
	resavgreviewscore int,
   
	primary key (resid)
);

-- T06.2: create sequence for RESID
create sequence res_seq
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T06.3: insert data to restaurant
insert into restaurant 
	values(1, 'Bobs Pizza', '4434568171', 'open', '123 street', '46172', 'Maryland', null, null);
insert into restaurant 
	values(res_seq.nextval, 'Timmy Tams', '4637263758', 'closed', '123 ave', '74582', 'New York', null, null);
insert into restaurant 
	values(res_seq.nextval, 'Burger Place', '7584726486', 'open', '123 drive', '18374', 'Maine', null, null);
	

-- T07 Restaurant Category
-- T0.0: drop res_cat table
drop table res_cat cascade constraints;

-- T07.1: create res_cat table
create table res_cat(
	catid int,
	resid int,

	primary key (catid, resid),
	foreign key (catid) references category,
	foreign key (resid) references restaurant
);

-- T07.3: insert data to res_cat 
insert into res_cat 
	values(1, 1);
insert into res_cat 
	values(2, 2);
insert into res_cat 
	values(3, 3);
