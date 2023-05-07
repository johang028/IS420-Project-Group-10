/*Individual Feature 1*/
select * from customer;
--customer already exists and updates information accordingly
exec add_customer ('Ben Franklin','77 Welt Avenue','NJ',67543,'benf@gmail.com');
select *from customer;
--new customer added
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


/*Individual Feature 4*/
--Regular case
exec print_dishes(1);
exec print_dishes(2);
--Special case
exec print_dishes(200);

/*Individual Feature 5*/
--Regular Case
exec display_cart(1);
--Special Case: invalid cart ID
exec display_cart(99);

/*Group Feature 9*/
--regular case
exec display_restaurant_reviews(1);

--special case: restaurant exists with no reviews
exec display_restaurant_reviews(4);

--special case: invalid restaurant ID
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
exec add_dish(100, 1, 1);

--Special case, restaurant id is invalid
exec add_dish(1, 100, 1);

--Special case, restaurant is closed
exec add_dish(1, 2, 1);

--Special case, dish id is invalid
exec add_dish(1, 1, 100);

--Special case, customer does not have a cart
select * from cart;
exec add_dish(3, 1, 1);
select * from cart;
