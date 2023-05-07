/*
Feature 4

Show dishes offered by a restaurant. Input is a restaurant ID. 
The procedure first checks whether this is a valid restaurant ID. 
If not, please print a message ‘no such restaurant’. Otherwise print out all dishes in this restaurant, along with dish name and price.
Assigned to: Katelyn Atkinson

*/

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
--Regular case
exec print_dishes(1);
exec print_dishes(2);
--Special case
exec print_dishes(200);

