/*
Feature 2

Given a customer email, first check if there is a customer with that email. If not, print a message now such as the customer. 
Otherwise print out the profile of the customer, including name, address, state, zip code, email, credit, total number of orders with status 2 (delivered) in the last six months and total amount spent (sum of total cost for orders with status 2) in the last six months.
Assigned to: Jawan Blunt 

*/ 

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
