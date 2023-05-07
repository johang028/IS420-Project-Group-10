/*
Feature 1

Create a new customer. Input includes customer name, address, state, zip, email. 
This feature checks whether any customer with the same email exists. If so, it prints a message 'the client already exists' and updates address, state, and zip. 
Otherwise, it generates a new customer ID (using sequence) and inserts a row into the customer table with given ID, name, address, state, zip, email and credit (as zero). 
Please also print out the new customer ID.
Assigned to: Immama Asif

*/

create or replace procedure customer(
	v_cid int not null,
	v_cname varchar2(255) not null,
	v_cadr varchar2(255),
	v_cstt varchar2(2),
	v_czip number(5),
	v_cemail varchar2(255),
	v_credit decimal,
)
as 
v_cid int; 
begin 
 -- Check if customer already exists
 insert into customer values(
select cid
  int v_cid
  from customer
  where cemail = v_cemail;

 -- If customer exists, update address, state, and zip
update customer 
set cadr =v_cadr,
cstt = v_cstt, 
czip =v_czip
where cid =v_cid;

 DBMS_OUTPUT.PUT_LINE('Customer already exists.');

Exception
 -- If customer does not exist, create new customer
  insert into customer (cid, cname, cadr,cstt, czip, cemail, credit)
    values (v_cid, v_cname, v_cadr, v_cstt, v_czip, v_cemail, 0);

    DBMS_OUTPUT.PUT_LINE('New customer created. Customer ID: ' || v_customer_id);
END;
/
