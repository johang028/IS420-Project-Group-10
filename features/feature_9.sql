--Feature 9
/*
Display all reviews of a restaurant. Input is restaurant ID. First check whether the restaurant ID is valid. If not, print a message. Then print out all reviews of the restaurant, including review date, score, and comment.
*/

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
--regular case
exec display_restaurant_reviews(1);
--special case: restaurant exists with no reviews
exec display_restaurant_reviews(4);
--special case: invalid restaurant ID
exec display_restaurant_reviews(255);
