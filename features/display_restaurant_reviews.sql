--Feature 9
/*
Display all reviews of a restaurant. Input is restaurant ID. First check whether the restaurant ID is valid. If not, print a message. Then print out all reviews of the restaurant, including review date, score, and comment.
*/

create or replace procedure display_restaurant_reviews(v_resid in int)
is
v_count int;
v_resname restaurant.resname%type;
v_rdate review.rvdate%type;
v_rvscr review.rvscr%type;
v_rvcmt review.rvcmt%type;

cursor c1 is
  select rvdate, rvscr, rvcmt
  from review r, restaurant rs 
  where r.resid = rs.resid and r.resid = v_resid;

begin
--check to see if input restaurant ID is valid
  select count(*) into v_count
  from restaurant
  where resid = v_resid;

if v_count = 0
  then dbms_output.put_line ('Invalid Restaurant ID');
else
--print out restaurant name based on corresponding restaurant ID
    select max(resname)
    into v_resname
    from restaurant rs, review r
    where rs.resid = r.resid and rs.resid = v_resid;
    dbms_output.put_line ('Customer Reviews for ' || v_resname );
-- display all reviews for restaurant
    open c1;
    loop
        fetch c1 into v_rdate, v_rvscr, v_rvcmt;        
        exit when c1%NOTFOUND;
        dbms_output.put_line (v_rdate || ' Rating: ' || v_rvscr || ' Review Comment: ' || v_rvcmt);
    end loop;
    close c1;
    end if;
     exception
        when no_data_found then
            dbms_output.put_line('No reviews found for this restaurant’');
end;
/
--regular case
exec display_restaurant_reviews(1);

--regular case
exec display_restaurant_reviews(2);

--special case: Invalid restaurant ID

exec display_restaurant_reviews(255)

--special case: No reviews found for restaurant
