/*
Feature 5

Show all dishes in a shopping cart. Input is a cart ID. 
First check whether that cart ID is valid. 
If not, print a message invalid cart ID. If the ID is valid, print out every dish in the shopping cart, including dish name, price, quantity.
Assigned to: Johan Galeza

*/

create or replace procedure display_cart(v_cartid in int)
as
v_count int;
cursor c1 is 
  select dishname, dishprice, quantity
  from cart c, cart_dish cd, dish d
  where c.cartid = cd.cartid and cd.dishid = d.dishid and cd.cartid = v_cartid;
  
Begin
-- check if cart ID is valid
  select count(*) into v_count
  from cart
  where cartid = v_cartid;
if v_count = 0 
  then dbms_output.put_line ('Invalid Cart ID');
--  displays all dishes in a shopping cart 
else
for r in c1 loop
    dbms_output.put_line ('Dish Name: ' || r.dishname || ' Quantity: ' || r.quantity || ' Dish Price: ' || r.dishprice);
  end loop;
  end if;
end;
/
--Regular Case
exec display_cart(1);
--Special Case: invalid cart ID
exec display_cart(99);
