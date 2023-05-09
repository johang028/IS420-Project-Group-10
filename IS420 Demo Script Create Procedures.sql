/*Feature 1*/
create or replace procedure add_customer(
    v_cname in varchar2,
    v_cadr in varchar2,
    v_cstt in varchar2,
    v_czip in number,
    v_cemail in varchar2
)
as 

v_count number;

begin 
 -- Check if customer with same email already exists
     select count(*) into v_count 
  from customer
  where cemail = v_cemail;

 -- If customer exists, update address, state, and zip
    if v_count > 0
    then
        update customer 
        set cadr = v_cadr,
                cstt = v_cstt, 
                czip = v_czip
        where cemail = v_cemail;

  dbms_output.put_line('Customer already exists. Address, state and zip are updated');

    else
     -- If customer does not exist, create new customer
  insert into customer (cid, cname, cadr, cstt, czip, cemail, credit)
    values (seq_cid.nextval, v_cname, v_cadr, v_cstt, v_czip, v_cemail, null);

  dbms_output.put_line('New customer created. Customer ID: ' || seq_cid.currval);
    end if;
end;
/
--customer already exists and updates information accordingly
exec add_customer ('Ben Franklin','77 Welt Avenue','NJ',67543,'benf@gmail.com');
--new customer added
exec add_customer ('Bronya Rand','419 Belobog Road','WA',22537,'bronrand@gmail.com');

/*Feature 2*/
create or replace procedure check_email(email in varchar2)
as
cursor c1 is select cname, cadr, cstt, czip, cemail, credit, 
count(status), sum(nvl(total_cost, 0)) -- nvl() to make sure 0 is included for those that dont have orders
from customer
left outer join itemOrder
on customer.cid = itemOrder.cid and itemOrder.status = 2 and (itemOrder.delivery_time between add_months(sysdate, -6) and sysdate)
where customer.cemail = email
group by cname, cadr, cstt, czip, cemail, credit;

--variables
cust_name customer.cname%type;
cust_adr customer.cadr%type;
cust_state customer.cstt%type;
cust_zip customer.czip%type;
cust_email customer.cemail%type;
cust_credit customer.credit%type;
total_delivered_count number;
total_spent itemOrder.total_cost%type;
email_count integer;
begin    
    /*check if email is in database. If there isnt, print message. If it is,
    execute code.*/
    select count(*)
    into email_count
    from customer
    where cemail = email;
        
    --valid email
    if not email like '%@%' then
       dbms_output.put_line('Please enter a valid email.'); 
    elsif email_count = 0 then
        dbms_output.put_line('No customer exists with this email!');
    else
        open c1;
        loop
            fetch c1 into cust_name, cust_adr, cust_state, cust_zip, cust_email, 
            cust_credit, total_delivered_count, total_spent;            
            exit when c1%NOTFOUND;
            
            dbms_output.put_line('Name = ' || cust_name);
            dbms_output.put_line('Address = ' || cust_adr); 
            dbms_output.put_line('State = ' || cust_state); 
            dbms_output.put_line('Zip Code = ' || cust_zip);
            dbms_output.put_line('Email = ' || cust_email);
            dbms_output.put_line('Credit = $' || cust_credit);
            dbms_output.put_line('Number of Delivered Orders in the Last 6 Months = ' || total_delivered_count);
            dbms_output.put_line('Total Cost of Delivered Orders in the Last 6 Months = ' || total_spent);
            
        end loop;
        close c1;
    end if;
    exception
        when no_data_found then
            dbms_output.put_line('No customer exists with this email!');
end;
/

--Feature 3
CREATE OR REPLACE PROCEDURE srch_res_by_cat(p_category_name IN VARCHAR2)
AS
    v_count int;
    CURSOR c1 IS SELECT r.resname, r.reszipcode, r.resavgreviewscore, r.resavgwaittime 
        FROM restaurant r
        JOIN res_cat rc ON r.resid = rc.resid
        JOIN category c ON rc.catid = c.catid
        WHERE LOWER(c.catname) LIKE '%' || LOWER(p_category_name) || '%'
        AND r.resstatus = 'open';
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM restaurant r
    JOIN res_cat rc ON r.resid = rc.resid
    JOIN category c ON rc.catid = c.catid
    WHERE LOWER(c.catname) LIKE '%' || LOWER(p_category_name) || '%'
    AND r.resstatus = 'open';
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Searching for restaurants under category keyword: ' || p_category_name);
        DBMS_OUTPUT.PUT_LINE('No restaurant under following category'); 
    ELSE
        DBMS_OUTPUT.PUT_LINE('Searching for restaurants under category: ' || p_category_name);
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('| Restaurant Name  | Zip Code | Avg Review Score | Ave Waiting Time (mins) |');
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
        FOR r IN c1 LOOP
            EXIT WHEN c1%notfound;
            DBMS_OUTPUT.PUT_LINE('| ' || RPAD(r.resname, 16) || ' | ' || RPAD(r.reszipcode, 8) || ' | ' || RPAD(r.resavgreviewscore, 17) || ' | ' || RPAD(r.resavgwaittime, 24) || ' |');
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
        END LOOP;
    END IF;
END;
/ 

/*Feature 4*/
--Show dishes offered by a restaurant. Input is a restaurant ID.
create or replace procedure print_dishes(res_id int)
as
    v_count int;
    cursor c1 is select dishname, dishprice
        from restaurant r, dish d
        where r.resid = res_id and r.resid = d.resid;
begin
    --First check that the input is a valid restaurant ID
    select count(*) into v_count
    from restaurant
    where resid = res_id;
    if v_count = 0 then
        dbms_output.put_line('No such restaurant');
    --If the ID is valid, print out all dishes with prices from restaurant
    else
        dbms_output.put_line('Restaurant with id = ' || res_id);
        dbms_output.put_line('Dishes:');
        for r in c1 loop
            exit when c1%notfound;
            dbms_output.put_line(r.dishname || ' - $' || r.dishprice);
        end loop;
    end if;
end;
/

/*Feature 5*/
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

/*Feature 9*/
create or replace procedure display_restaurant_reviews(v_resid in int)
is
  v_count int;
  v_resname restaurant.resname%type;

  cursor c1 is
    select rvdate, rvscr, rvcmt
    from review r, restaurant rs 
    where r.resid = rs.resid and r.resid = v_resid;

begin
  -- check to see if input restaurant ID is valid
  select count(*) into v_count
  from restaurant
  where resid = v_resid;

  if v_count = 0 then 
    dbms_output.put_line ('Invalid Restaurant ID');
  else
    -- print out restaurant name based on corresponding restaurant ID
    select max(resname)
    into v_resname
    from restaurant rs, review r
    where rs.resid = r.resid and rs.resid = v_resid;
    
    --check if reviews exist for restaurant
    if v_resname is null then
        dbms_output.put_line ('No reviews found for this restaurant');
    else
        dbms_output.put_line ('Customer Reviews for ' || v_resname );

    -- display all reviews for restaurant
   for r in c1 loop
    dbms_output.put_line (r.rvdate || ' Rating: ' || r.rvscr || ' Review Comment: ' || r.rvcmt );  
        end loop;
    end if;
  end if;
end;
/


/*Feature 10*/
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
                            select cartid into cart_id
                            from cart
                            where cid = c_id and resid = res_id;
                            insert into cart_dish values(cart_id, res_id, dish_id, 1);
                            dbms_output.put_line('Dish added to the cart.');
                    
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end if;
end;
/
