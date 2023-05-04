--Feature 10
/*
Add a dish to the shopping cart. Input includes customer ID, restaurant ID, and a dish ID. 
First check whether the customer ID is valid. If not, print out a message with no such customer. 
Then check whether the restaurant ID is valid and the restaurant is open. If not print out invalid restaurant ID or the restaurant is closed. 
Finally check whether the dish belongs to the input restaurant. If it does not print out an invalid dish ID. 
Otherwise where there is an existing shopping cart for the customer. If the cart does not exist, create a new cart for the customer and restaurant and print out the new cart ID.
Now you can check whether the dish is already in the cart. If so, just increase the quantity by one. Otherwise inserting a new row to the table keeps dishes in a cart.
*/

create or replace procedure add_dish(c_id int, res_id int, dish_id int)
as
    v_count int;
    status restaurant.resstatus%type;
    cart_id cart.cartid%type;
begin
    --First check it is a valid customer ID
    select count(*) into v_count
    from customer
    where cid = c_id;
    if v_count = 0 then
        dbms_output.put_line('No such customer.');
        
    --Check it is a valid restaurant ID
    else
        select count(*) into v_count
        from restaurant
        where resid = res_id;
        if v_count = 0 then
            dbms_output.put_line('No such restaurant.');
            
        --Check if the restaurant is closed
        else
            select resstatus into status
            from restaurant
            where resid = res_id;
            if status = 'closed' then
                dbms_output.put_line('Restaurant is closed!');
                
            --Check if the dish is attached to the restaurant
            else
                select count(*) into v_count
                from restaurant r, dish d
                where r.resid = res_id and d.dishid = dish_id and d.resid = r.resid;
                if v_count = 0 then
                    dbms_output.put_line('Invalid dish id.');
                    
                --Check if a cart exists with the customer
                else
                    select count(*) into v_count
                    from cart
                    where cid = c_id;
                    if v_count = 0 then
                        dbms_output.put_line('Cart does not exist!');
                        
                        cart_id := seq_cart.nextval;
                        insert into cart values(cart_id, c_id, res_id);
                        
                        dbms_output.put_line('New cart created with id: ' || cart_id);
                    --If the dish is already in the cart, increase the quantity by one
                    else
                        select count(*)
                        into v_count
                        from cart_dish
                        where dishid = dish_id and resid = res_id;
                        
                        if v_count = 1 then
                            update cart_dish
                            set quantity = quantity + 1
                            where resid = res_id and dishid = dish_id;
                            dbms_output.put_line('Dish quantity increased by one.');
                            
                        --If everything is valid and the dish is not already in the cart
                        --Add the dish to the cart
                        else
                            insert into cart_dish values(seq_cart.nextval, res_id, dish_id, 1);
                            dbms_output.put_line('Dish added to the cart.');
                    
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end if;
end;
/
--Regular case, dish is already in cart
exec add_dish(1, 1, 1);
--Regular case, dish is not in cart
exec add_dish(1, 1, 1);
--Special case, customer id is invalid
exec add_dish(100, 1, 1);
--Special case, restaurant id is invalid
exec add_dish(1, 100, 1);
--Special case, restaurant is closed
exec add_dish(1, 2, 1);
--Special case, dish id is invalid
exec add_dish(1, 1, 100);
--Special case, customer does not have a cart
exec add_dish(3, 1, 1);
