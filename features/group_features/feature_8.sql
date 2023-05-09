/*
Feature 8

Enter a review. Input includes a customer ID, a restaurant ID, a review date, a review score and review comment. This procedure does the following:
first check if the customer ID is valid. If not, print a message saying invalid customer ID. 
Check if the restaurant ID is valid. If not, print a message saying invalid restaurant ID. 
if both are valid, insert a row into the review table with the input customer id, restaurant ID, review date, score and comment. 
update the average review score of the restaurant to reflect the new review.
Lead:  Immama Asif
Assist: Johan Galeza

*/

create or replace procedure enter_review(v_cid in number, v_resid in number, v_rvdate in date, v_rvscr in number, v_rvcmt in varchar2)
is
cus_count int;
res_count int;

begin
--check if input customer ID is invalid
select count(*) into cus_count
from customer
where cid = v_cid;

if cus_count = 0
  then dbms_output.put_line ('The customer ID is invalid.');
else
--check if given restaurant ID is invalid
  select count(*) into res_count
  from restaurant
  where resid = v_resid;
if res_count = 0
  then dbms_output.put_line ('The restaurant ID is invalid.');
else
--insert row into review table
  insert into review
  values (seq_rvid.nextval,v_cid,v_resid,v_rvdate,v_rvscr,v_rvcmt);

--update average review score
update restaurant
  set resavgreviewscore =
    (select avg(rvscr)
      from review
      where resid = v_resid)
  where resid = v_resid;

  dbms_output.put_line ('Restaurant review score updated');
  end if;
  end if;
end;
/
--regular case
exec enter_review (2,2, date '2023-04-06',4,'Good desserts and lots of options');
--special case: invalid customer ID
exec enter_review (20,2, date '2023-04-26',2,'I found plastic in my steak');
--special case: invalid restaurant ID
exec enter_review (1,21, date '2023-05-01',3,'Food was mediocre, but service was great. Felt welcomed');
