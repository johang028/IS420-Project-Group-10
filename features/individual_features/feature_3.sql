/*
Feature 3

Search for a restaurant by category. Input is a part of category name (e.g., for fast food the input could be just 'fast'). 
Please print out the name, average review score, average wait time, and zip code for restaurants that are open and match the input category name.
Assigned to: Sung Ji

*/

CREATE OR REPLACE FUNCTION srch_by_cat(category_name_in IN VARCHAR2)
RETURN sys_refcursor
AS
  search_results sys_refcursor;
BEGIN
  OPEN search_results FOR
    SELECT r.resname, r.resavgreviewscore, r.resavgwaittime, r.reszipcode
    FROM restaurant r
    JOIN res_cat rc ON r.resid = rc.resid
    JOIN category c ON rc.catid = c.catid
    WHERE c.catname LIKE '%' || category_name_in || '%'
      AND r.resstatus = 'open';
  RETURN search_results;
END;
/
