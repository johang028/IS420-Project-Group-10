/*
Feature 6

Remove a dish from the shopping cart. Input includes dish ID and cart ID. 
First check whether the cart with the given ID has that dish. If not, print a message 'Invalid input'. 
If the input ID is valid, check the quantity of that dish. If it is more than one, then reduce the quantity of that dish from the cart and print a message saying ‘quantity reduced’. 
If the quantity is one, delete that row from the cart and print out 'dish removed'.
Lead: Katelyn Atkinson
Assist: Immama Asif

*/

--Remove a dish from the shopping cart. Input includes dish ID and cart ID.
create or replace procedure remove_dish(dish_id int, cart_id int)
as
    v_count int;
begin
    --Prints a message ‘Invalid input’ if the given dish is not in the given cart.
    select count(*) into v_count
    from cart_dish
    where dishid = dish_id and cartid = cart_id;
    if v_count = 0 then
        dbms_output.put_line('Invalid input');
    --if there is more than one of the given dish the quantity is reduced by one
    --and prints the message ‘quantity reduced’
    else
        select quantity into v_count
        from cart_dish
        where cartid = cart_id and dishid = dish_id;
        if v_count > 1 then
            update cart_dish
            set quantity = quantity - 1
            where cartid = cart_id and dishid = dish_id;
            dbms_output.put_line('Quantity reduced');
        --if the quantity is one the given dish row is deleted from the cart 
        --and print out ‘dish removed’
        else
            delete from cart_dish
            where cartid = cart_id and dishid = dish_id and quantity = 1;
            dbms_output.put_line('Dish removed');
        end if;
    end if;
end;
/
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
