--Feature 3
/*
Search for a restaurant by category. Input is a part of category name (e.g., for fast food the input could be just 'fast'). 
Please print out the name, average review score, average wait time, 
and zip code for restaurants that are open and match the input category name. 
*/

CREATE OR REPLACE FUNCTION search_restaurant_by_category(input_category IN VARCHAR2)
RETURN SYS_REFCURSOR
IS
  result_set SYS_REFCURSOR;
BEGIN
  OPEN result_set FOR 
  SELECT r.resname, r.resavgreviewscore, r.resavgwaittime, r.reszipcode
  FROM restaurant r
  INNER JOIN category c ON r.resid = c.catid
  WHERE c.catname LIKE '%' || input_category || '%'
  AND r.resstatus = 'open';
  RETURN result_set;
END;

DECLARE
  search_results SYS_REFCURSOR;
  r_name restaurant.resname%TYPE;
  r_review_score restaurant.resavgreviewscore%TYPE;
  r_wait_time restaurant.resavgwaittime%TYPE;
  r_zipcode restaurant.reszipcode%TYPE;
BEGIN
  search_results := search_restaurant_by_category('Fast Food');
  LOOP
    FETCH search_results INTO r_name, r_review_score, r_wait_time, r_zipcode;
    EXIT WHEN search_results%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Restaurant Name: ' || r_name || ', Average Review Score: ' || r_review_score || ', Average Wait Time: ' || r_wait_time || ', Zip Code: ' || r_zipcode);
  END LOOP;
  CLOSE search_results;
END;
