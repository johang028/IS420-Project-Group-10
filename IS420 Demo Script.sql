--T01 Customer
DROP TABLE customer cascade constraints; 
DROP sequence seq_cid;

--T02 Discount
DROP TABLE discount cascade constraints; 
DROP sequence discount_seq;

--T03 Sales Tax
DROP TABLE salestax cascade constraints; 
DROP sequence seq_stid;

--T04 Customer Discount
DROP TABLE customer_discount cascade constraints; 

--T05 Restaurant
DROP TABLE restaurant cascade constraints; 
DROP sequence res_seq;

--T06 Review
DROP TABLE review cascade constraints;
DROP sequence seq_rvid;

--T07 Dish
DROP TABLE dish cascade constraints; 
DROP sequence dish_seq;

--T08 Category
DROP TABLE category cascade constraints; 
DROP sequence cat_seq;

--T09 Restaurant Category
DROP TABLE res_cat cascade constraints; 

--T10 Cart
DROP TABLE cart cascade constraints; 
DROP sequence seq_cart;

--T11 Cart Dish
DROP TABLE cart_dish cascade constraints;

--T12 Order
DROP TABLE itemOrder cascade constraints; 
DROP sequence seq_itemOrder;

--T13 Dish Order
DROP TABLE dish_order cascade constraints;

--T14 Payment
DROP TABLE payment cascade constraints; 
DROP sequence pay_seq;

--T15 Message
DROP TABLE message cascade constraints; 
DROP sequence mes_seq;

-- T01 Customer
-- T01.1: create customer table
CREATE TABLE customer (
	cid int not null,
	cname varchar2 (255) not null,
	cadr varchar2 (255),
	cstt varchar2 (2),
	czip varchar2 (5),
	cemail varchar2 (255),
	credit decimal,
	
	primary key (cid)
);

-- T01.2: create autosequence for CID
CREATE sequence seq_cid
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T01.3: insert data to customer
INSERT INTO customer 
	VALUES (seq_cid.nextval, 'Wendi Robles', '202 W. Shore Ave', 'OH', 43612, 'rattha@problemstory.us', 0);
INSERT INTO customer 
	VALUES (seq_cid.nextval, 'Darnell House', '7765 Taklin Hill Dr.', 'CA', 95301, 'fxllipek@mtcxmail.com', 350.00);
INSERT INTO customer
	VALUES (seq_cid.nextval, 'Korey Booth', '67 Sycamore St', 'GA', 31021, 'tavaira@kientao.online', 200.00);
INSERT INTO customer
	VALUES (seq_cid.nextval, 'Milly Jenkins', '13458 Centennial Lane', 'MD', 21042, 'milly@gmail.com', 15.00);
INSERT INTO customer
	VALUES (seq_cid.nextval, 'Sam Houston', '4277 Winsor mills rd.', 'MD', 22442, 'sam@gmail.com', 1.00);
INSERT INTO customer
	VALUES (seq_cid.nextval, 'Ben Franklin', '84 Milky way', 'MD', 21444, 'benf@gmail.com', 0);
INSERT INTO customer
	VALUES (seq_cid.nextval, 'Connor Bedard', '501 Broadway', 'TN', 37203, 'connor@gmail.com', 1000);

-- T02 Discount
-- T02.1: create discount table
CREATE TABLE discount (
	did int,
	discount_description varchar2 (255),
	discount_type int,

	primary key (did)
);

-- T02.2: create autosequence for DID
CREATE sequence discount_seq
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T02.3: insert date to discount
INSERT INTO discount (did, discount_description, discount_type) 
	VALUES (discount_seq.nextval, 'Free delivery', 1);
INSERT INTO discount (did, discount_description, discount_type) 
	VALUES (discount_seq.nextval, '10% off total charge', 2);
INSERT INTO discount (did, discount_description, discount_type) 
	VALUES (discount_seq.nextval, '20% off total charge', 3);
INSERT INTO discount (did, discount_description, discount_type) 
	VALUES (discount_seq.nextval, '30% off total charge', 4);
INSERT INTO discount (did, discount_description, discount_type) 
	VALUES (discount_seq.nextval, '40% off total charge', 5);
INSERT INTO discount (did, discount_description, discount_type) 
	VALUES (discount_seq.nextval, '50% off total charge', 6);


-- T03 Sale Tax
-- T03.1: create saletax table
CREATE TABLE salestax (
	stid int not null,
	ststt varchar2(2) not null,
	strt decimal not null,
	
	primary key (stid)
);

-- T03.2: create sequence for STID
CREATE sequence seq_stid
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T03.3: insert data to saletax
INSERT INTO salestax
	VALUES (seq_stid.nextval, 'AL', 0.0400);
INSERT INTO salestax
	VALUES (seq_stid.nextval, 'AK', 0.0000);
INSERT INTO salestax
	VALUES (seq_stid.nextval, 'DC', 0.0600);
INSERT INTO salestax
	VALUES (seq_stid.nextval, 'MA', 0.0550);
INSERT INTO salestax
	VALUES (seq_stid.nextval, 'MD', 0.0600);
INSERT INTO salestax
	VALUES (seq_stid.nextval, 'NY', 0.0450);
INSERT INTO salestax
	VALUES (seq_stid.nextval, 'PA', 0.0600);
INSERT INTO salestax
	VALUES (seq_stid.nextval, 'VA', 0.0530);
INSERT INTO salestax
	VALUES (seq_stid.nextval, 'TX', 0.0625);

-- T04 Customer Discount
-- T04.1: create customer_discount table
CREATE TABLE customer_discount (
	cid int not null,
	did int not null,
	discount_start_date date not null,
	discount_end_date date not null,

	primary key (cid, did),
	foreign key (cid) references customer(cid),
	foreign key (did) references discount(did)
);

-- T04.2: insert data to customer_discount
INSERT INTO customer_discount (cid, did, discount_start_date, discount_end_date) 
	VALUES (1, 1, date '2023-02-12', date '2023-02-18');
INSERT INTO customer_discount (cid, did, discount_start_date, discount_end_date) 
	VALUES (2, 2, date '2023-06-11', date '2023-06-17');
INSERT INTO customer_discount (cid, did, discount_start_date, discount_end_date) 
	VALUES (3, 3, date '2023-01-09', date '2023-02-15');

-- T05 Restaurant
-- T05.1: create restaurant table
CREATE TABLE restaurant(
	resid int,
	resname varchar2 (255) not null,
	resphonenum varchar2 (10),
	resstatus varchar2 (6), --open or closed
	resaddress varchar2 (255),
	reszipcode number (5),
	resstate varchar2 (2),
	resavgwaittime int,
	resavgreviewscore int,
	
	primary key (resid)
);

-- T05.2: create sequence for RESID
CREATE sequence res_seq
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T05.3: insert data to restaurant
INSERT INTO restaurant 
	VALUES (res_seq.nextval, 'Bobs Pizza', '4434568171', 'open', '123 street', '46172', 'MD', null, null);
INSERT INTO restaurant 
	VALUES(res_seq.nextval, 'Timmy Tams', '4637263758', 'closed', '123 ave', '74582', 'NY', null, null);
INSERT INTO restaurant 
	VALUES(res_seq.nextval, 'Burger Place', '7584726486', 'open', '123 drive', '18374', 'MA', null, null);
INSERT INTO restaurant 
	VALUES(res_seq.nextval, 'McDonald''s', '4107885089', 'open', '5637 Baltimore National Pike', '21228', 'MD', null, null);
INSERT INTO restaurant 
	VALUES(res_seq.nextval, 'Wendy''s', '4107474489', 'open', '6600 Baltimore National Pike', '21228', 'MD', null, null);


-- T06 Review
-- T09.1: create review table
CREATE TABLE review (
	rvid int not null,
	cid int not null,
	resid int not null,
	rvdate date not null,
	rvscr decimal not null check (rvscr between 0.0 and 5.0),
	rvcmt varchar2 (255),
	
	primary key (rvid),
	foreign key (cid) references customer (cid),
	foreign key (resid) references restaurant (resid)
);

-- T06.2: create sequence for RVID
CREATE sequence seq_rvid
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T06.3: insert data to review
INSERT INTO review
	VALUES (seq_rvid.nextval, 3, 3, date '2023-02-01', 1.0, 'Terrible');
INSERT INTO review
	VALUES (seq_rvid.nextval, 1, 1, date '2023-02-02', 5.0, 'very good');
INSERT INTO review
	VALUES (seq_rvid.nextval, 2, 2, date '2023-02-04', 4.0, 'It is okay');
INSERT INTO review
	VALUES (seq_rvid.nextval, 1, 2, date '2023-02-02', 4.5, 'food is good, service is okay');

-- T07 Dish
-- T07.1: create dish table
CREATE TABLE dish(
	dishid int,
	resid int,
	dishname varchar2 (30),
	dishprice decimal (5,2),
	
	primary key (dishid),
	foreign key (resid) references restaurant
);

-- T07.2: create sequence for DISHID
CREATE sequence dish_seq
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T07.3: insert data to dish
INSERT INTO dish 
	VALUES (dish_seq.nextval, 1, 'Cheese Pizza', 9.00);
INSERT INTO dish 
	VALUES (dish_seq.nextval, 1, 'Pineapple Pizza', 10.00);
INSERT INTO dish 
	VALUES (dish_seq.nextval, 1, 'Vegan Pizza', 19.99);
INSERT INTO dish 
	VALUES (dish_seq.nextval, 2, 'Tams', 2);
INSERT INTO dish 
	VALUES (dish_seq.nextval, 3, 'Veggie Burger', 35);

-- T08 Category
-- T08.1: create category table
CREATE TABLE category(
	catid int,
	catname varchar2 (64),
	
	primary key (catid)
);

-- T08.2: create sequence for CATID
CREATE sequence cat_seq
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T08.3: insert data to category
INSERT INTO category 
	VALUES (cat_seq.nextval, 'Italian');
INSERT INTO category 
	VALUES (cat_seq.nextval, 'Fast Food');
INSERT INTO category 
	VALUES (cat_seq.nextval, 'American');
INSERT INTO category 
	VALUES (cat_seq.nextval, 'French');

-- T09 Restaurant Category
-- T09.1: create res_cat table
CREATE TABLE res_cat(
	catid int,
	resid int,

	primary key (catid, resid),
	foreign key (catid) references category,
	foreign key (resid) references restaurant
);

-- T09.3: insert data to res_cat 
INSERT INTO res_cat 
	VALUES (1, 1);
INSERT INTO res_cat 
	VALUES (2, 2);
INSERT INTO res_cat 
	VALUES (3, 3);
INSERT INTO res_cat 
	VALUES (2, 4);
INSERT INTO res_cat 
	VALUES (2, 5);


-- T10 Cart
-- T10.1: create cart table
CREATE TABLE cart(
	cartid int,
	cid int,
	resid int,
	
	primary key (cartid),
	foreign key (cid) references customer,
	foreign key (resid) references restaurant
);

-- T10.2: create sequence for CARTID
CREATE sequence seq_cart
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T10.3: insert data to cart
INSERT INTO cart
	VALUES (seq_cart.nextval, 1, 1);
INSERT INTO cart
	VALUES (seq_cart.nextval, 1, 2);
INSERT INTO cart
	VALUES (seq_cart.nextval, 2, 2);

-- T11 Cart Dish
-- T11.1: create cart_dish table
CREATE TABLE cart_dish(
	cartid int,
	resid int,
	dishid int,
	quantity int,
	
	foreign key (cartid) references cart,
	foreign key (resid) references restaurant,
	foreign key (dishid) references dish
);

-- T11.2: insert data to cart_dish
INSERT INTO cart_dish
	VALUES (1, 1, 1, 10);
INSERT INTO cart_dish
	VALUES (2, 2, 1, 5);
INSERT INTO cart_dish
	VALUES (3, 2, 2, 15);
INSERT INTO cart_dish
	VALUES (1, 3, 5, 1);

-- T12 Order
-- T12.1: create itemorder table
CREATE TABLE itemOrder(
	orderid int,
	cid int, 
	resid int,
	order_time timestamp,
	delivery_time timestamp,
	estimated_time timestamp,
	status int,
	payment_status int, 
	total_cost decimal (5,2), 
	delivery_method int,
	
	primary key (orderid),
	foreign key (cid) references customer,
	foreign key (resid) references restaurant, 
	constraint check_order_delivery_method check(delivery_method in (1, 2)),
	constraint check_order_status check(status in (1, 2, 3))
);

-- T12.2: create sequence for ORDERID
CREATE sequence seq_itemOrder
	minvalue 0
	start with 1
	increment by 1
	cache 50;

INSERT INTO itemOrder
	VALUES (seq_itemOrder.nextval, 1, 1, timestamp '2023-3-12 09:00:30.75', timestamp '2023-3-12 09:30:30.75', timestamp '2023-3-12 09:20:30.75', 1, 1, 20.20, 1);
INSERT INTO itemOrder
	VALUES (seq_itemOrder.nextval, 2, 2, timestamp '2023-3-12 10:00:30.75', null, timestamp '2023-3-12 10:15:30.75', 1, 2, 50.25, 2);
INSERT INTO itemOrder
	VALUES (seq_itemOrder.nextval, 3, 2, timestamp '2023-3-12 12:15:30.75', null, null, 3, 2, 0, 2);
INSERT INTO itemOrder 
	VALUES (seq_itemOrder.nextval, 4, 1, sysdate, sysdate, sysdate, 2, 2, 100, 2);
INSERT INTO itemOrder 
	VALUES (seq_itemOrder.nextval, 4, 1, sysdate, sysdate, sysdate, 2, 2, 18, 1);
INSERT INTO itemOrder 
	VALUES (seq_itemOrder.nextval, 4, 1, sysdate, sysdate, sysdate, 2, 2, 40, 1);
INSERT INTO itemOrder 
	VALUES (seq_itemOrder.nextval, 5, 2, sysdate, sysdate, sysdate, 2, 2, 27, 1);
INSERT INTO itemOrder 
	VALUES (seq_itemOrder.nextval, 5, 2, sysdate, sysdate, sysdate, 2, 2, 15, 2);
INSERT INTO itemOrder 
	VALUES (seq_itemOrder.nextval, 5, 2, sysdate, null, null, 3, 2, 0, 2);
INSERT INTO itemOrder 
	VALUES (seq_itemOrder.nextval, 6, 1, timestamp '2022-3-12 09:00:30.75', timestamp '2022-3-12 09:50:30.75', timestamp '2022-3-12 09:40:30.75', 2, 2, 50, 2);
INSERT INTO itemOrder 
	VALUES (seq_itemOrder.nextval, 6, 1, timestamp '2022-4-12 09:00:30.75', timestamp '2022-4-12 09:50:30.75', timestamp '2022-4-12 09:40:30.75', 2, 2, 60, 1);
INSERT INTO itemOrder 
	VALUES (seq_itemOrder.nextval, 6, 1, timestamp '2022-5-12 09:00:30.75', timestamp '2022-5-12 09:50:30.75', timestamp '2022-5-12 09:40:30.75', 2, 2, 63, 1);

-- T13 Dish Order
-- T13.1: create dish_order table
CREATE TABLE dish_order (
	orderid int,
	dishid  int,
	
	primary key (orderid, dishid),
	foreign key (orderid) references itemOrder (orderid),
	foreign key (dishid) references dish (dishid)
);

-- T13.2: insert data to dish_order
INSERT INTO dish_order 
	VALUES (1,1);
INSERT INTO dish_order 
	VALUES (2,2);
INSERT INTO dish_order 
	VALUES (3,3);

-- T14 Payment
-- T14.1: create payment table
CREATE TABLE payment (
	payid int,
	orderid int,
	cid int,
	pamount number(5,2),
	method varchar(255)
	constraint check_payment check(method in ('Credit/Debit Card','Apple Pay','PayPal')) not null,
	
	primary key (payid),
	foreign key (orderid) references itemOrder (orderid),
	foreign key (cid) references customer (cid)
);

-- T14.2: create sequence for PAYID
CREATE sequence pay_seq
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T14.3: insert data to payment
INSERT INTO payment 
	VALUES (pay_seq.nextval,1,1,76.88,'Credit/Debit Card');
INSERT INTO payment 
	VALUES (pay_seq.nextval,2,2,64.12,'Credit/Debit Card');
INSERT INTO payment 
	VALUES (pay_seq.nextval,3,3,97.57,'Apple Pay');

-- T15 Message
-- T15.1: create message table
CREATE TABLE message (
	mesid int,
	cid int,
	mtime date,
	mbody varchar2 (255),

	primary key (mesid),
	foreign key (cid) references customer (cid)
);

-- T15.2: create sequence for MESID
CREATE sequence mes_seq
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T15.3: insert data to message
INSERT INTO message 
	VALUES (mes_seq.nextval, 1, date '2023-1-28', 'Receipt concerns with previous visit to the restaurant');
INSERT INTO message 
	VALUES (mes_seq.nextval, 2, date '2023-1-30', 'A personal message thanking the head chef.');
INSERT INTO message 
	VALUES (mes_seq.nextval, 3, date '2023-2-15', 'Is this restaurant open on weekends?');

/*Individual Feature 1*/
--customer already exists and updates information accordingly
select * from customer;
exec add_customer ('Ben Franklin','77 Welt Avenue','NJ',67543,'benf@gmail.com');
select *from customer;

--new customer added
select * from customer;
exec add_customer ('Bronya Rand','419 Belobog Road','WA',22537,'bronrand@gmail.com');
select * from customer;

/*Individual Feature 2*/
--regular case: email found. Customer has 0 Delivered Orders in the last 6 months, 1 total order (0 Delivered)| Customer = Wendi (CID = 1)
exec check_email('rattha@problemstory.us');

--regular case: email found. Has 3 Delivered Orders in the last 6 months, 3 total orders (All delivered) | Customer = Milly (CID = 4)
exec check_email('milly@gmail.com');

--regular case: email found. Has 2 Delivered Orders in the last 6 months, 3 total orders (2 Delivered, 1 Not) | Customer = Sam (CID = 5)
exec check_email('sam@gmail.com');

--regular case: email found. Has 0 Delivered Orders in the last 6 months, 3 total orders (3 Delivered) | Customer = Ben (CID = 6)
exec check_email('benf@gmail.com');

--test case: email not found in the database
exec check_email('ceo123@gmail.com');

--test case: email is invalid (no '@')
exec check_email('abcxyz');

--test case: email found. customer has 0 orders | Customer = Connor (CID = 7)
exec check_email('connor@gmail.com');

/*Individual Feature 3*/
--regular code
exec srch_res_by_cat ('food');
--special case; 0 result
exec srch_res_by_cat ('asian');

/*Individual Feature 4*/
--Regular case
select * from dish;
exec print_dishes(1);

select * from dish;
exec print_dishes(2);

--Special case
select * from dish;
exec print_dishes(200);

/*Individual Feature 5*/
--Regular Case
exec display_cart(1);

--Special Case: invalid cart ID
exec display_cart(99);

/*Group Feature 9*/
--regular case
select * from restaurant;
select * from review;
exec display_restaurant_reviews(1);

--special case: restaurant exists with no reviews
select * from restaurant;
select * from review;
exec display_restaurant_reviews(4);

--special case: invalid restaurant ID
select * from restaurant;
select * from review;
exec display_restaurant_reviews(255);

/*Group Feature 10*/
--Regular case, dish is already in cart
select * from cart_dish;
exec add_dish(1, 1, 1);
select * from cart_dish;

--Regular case, dish is not in cart
select * from cart_dish;
exec add_dish(1, 1, 3);
select * from cart_dish;

--Special case, customer id is invalid
select * from cart_dish;
exec add_dish(100, 1, 1);
select * from cart_dish;

--Special case, restaurant id is invalid
select * from cart_dish;
exec add_dish(1, 100, 1);
select * from cart_dish;

--Special case, restaurant is closed
select * from cart_dish;
exec add_dish(1, 2, 1);
select * from cart_dish;

--Special case, dish id is invalid
select * from cart_dish;
exec add_dish(1, 1, 100);
select * from cart_dish;

--Special case, customer does not have a cart
/*added drop and create statement to ensure cartid.nextval is proper (id would be 5 instead of 4 if no drop and create here)*/
DROP TABLE cart cascade constraints; 
DROP sequence seq_cart;

CREATE sequence seq_cart
	minvalue 0
	start with 1
	increment by 1
	cache 50;

-- T10.3: insert data to cart
INSERT INTO cart
	VALUES (seq_cart.nextval, 1, 1);
INSERT INTO cart
	VALUES (seq_cart.nextval, 1, 2);
INSERT INTO cart
	VALUES (seq_cart.nextval, 2, 2);

select * from cart;
exec add_dish(3, 1, 1);
select * from cart;
