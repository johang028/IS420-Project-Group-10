--Feature 1
/*
Create a new customer. Input includes customer name, address, state, zip, email. 
This feature checks whether any customer with the same email exists. If so, it prints a message 'the client already exists' and updates address, state, and zip. 
Otherwise, it generates a new customer ID (using sequence) and inserts a row into the customer table with given ID, name, address, state, zip, email and credit (as zero). 
Please also print out the new customer ID.
*/


--Feature 2
/*
Given a customer email, first check if there is a customer with that email. If not, print a message now such as the customer. 
Otherwise print out the profile of the customer, including name, address, state, zip code, email, credit, 
total number of orders with status 2 (delivered) in the last six months and 
total amount spent (sum of total cost for orders with status 2) in the last six months.
*/


--Feature 3
--Moved to feature folder [Sung]


--Feature 4
/*
Show dishes offered by a restaurant. Input is a restaurant ID. 
The procedure first checks whether this is a valid restaurant ID. If not, please print a message ‘no such restaurant’. 
Otherwise print out all dishes in this restaurant, along with dish name and price.


--Feature 5
/*
Show all dishes in a shopping cart. Input is a cart ID. First check whether that cart ID is valid. If not, print
a message invalid cart ID. If the ID is valid, print out every dish in the shopping cart, including dish
name, price, quantity.
*/

create or replace procedure display_cart(v_cartid in int)
is
v_count int;
cursor c1 is 
  select dishname, dishprice, quantity
  from cart c, cart_dish cd, dish d
  where c.cartid = cd.cartid and cd.dishid = d.dishid and cd.cartid = v_cartid;
  
begin
  select count(*) into v_count
  from cart
  where cartid = v_cartid;
--Check if Cart ID is valid
if v_count = 0 
  then dbms_output.put_line ('Invalid Cart ID');
else
for r in c1 loop
    dbms_output.put_line ('Dish Name: ' || r.dishname || 'Quantity: ' || r.quantity || 'Dish Price: ' || r.dishprice);
  end loop;
  end if;
end;
/
--Regular Case
exec display_cart(1);
--Special Case: Invalid Cart ID
exec display_cart(99);
