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
select * from dish;
select * from cart_dish;
exec display_cart(1);

--Special Case: invalid cart ID
select * from cart_dish;
exec display_cart(99);

/*Group Feature 6*/
--Regular case, dish is in the cart and has a quantity of 1
select * from cart_dish;
exec remove_dish(5,1);
select * from cart_dish;

--Regular case, dish is in the cart and has a quantity of more than 1
select * from cart_dish;
exec remove_dish(1,1);
select * from cart_dish;

--Special case
exec remove_dish(50,50);

/*Group Feature 7*/
--test case: invalid order id
exec update_itemOrder_status(99, 2, timestamp '2023-3-12 09:00:30.75');

--regular case: update status to 1 (order id 4 has default status of 2)
select * from itemOrder;
exec update_itemOrder_status(4, 1, timestamp '2023-3-12 09:00:30.75');
select * from itemOrder;

--regular case: update status to 2 (order id 1 has a default status of 1)
select * from itemOrder;
select * from message;
exec update_itemOrder_status(1, 2, timestamp '2023-3-12 09:00:30.75');
select * from itemOrder;
select * from message;

--regular case: update status to 3 (order id 2 has a default status of 1) | Works correctly
select * from message;
select * from payment;
exec update_itemOrder_status(2, 3, timestamp '2023-3-12 09:00:30.75');
select * from message;
select * from payment;

/*Group Feature 8*/
--regular case
select * from review;
exec enter_review (2,2, date '2023-04-06',4,'Good desserts and lots of options');
select * from review;

--special case: invalid customer ID
exec enter_review (20,2, date '2023-04-26',2,'I found plastic in my steak');

--special case: invalid restaurant ID
exec enter_review (1,21, date '2023-05-01',3,'Food was mediocre, but service was great. Felt welcomed');

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
CREATE TABLE cart(
	cartid int,
	cid int,
	resid int,
	
	primary key (cartid),
	foreign key (cid) references customer,
	foreign key (resid) references restaurant
); 
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
