/*
Feature 1

Create a new customer. Input includes customer name, address, state, zip, email. 
This feature checks whether any customer with the same email exists. If so, it prints a message 'the client already exists' and updates address, state, and zip. 
Otherwise, it generates a new customer ID (using sequence) and inserts a row into the customer table with given ID, name, address, state, zip, email and credit (as zero). 
Please also print out the new customer ID.
Assigned to: Immama Asif

*/

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
