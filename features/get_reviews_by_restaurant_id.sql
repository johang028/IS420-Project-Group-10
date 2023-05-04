CREATE OR REPLACE FUNCTION get_reviews_by_restaurant_id(input_resid IN INT)
RETURN SYS_REFCURSOR
IS
   v_cursor SYS_REFCURSOR;
BEGIN
   SELECT r.rvdate, r.rvscr, r.rvcmt
   INTO v_cursor
   FROM review r
   WHERE r.resid = input_resid;
   
   RETURN v_cursor;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Invalid restaurant ID.');
      RETURN NULL;
END;
/
