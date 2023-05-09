--Feature 3
/*
Search for a restaurant by category. Input is a part of category name (e.g., for fast food the input could be just 'fast'). 
Please print out the name, average review score, average wait time, 
and zip code for restaurants that are open and match the input category name. 
*/

CREATE OR REPLACE PROCEDURE srch_res_by_cat(p_category_name IN VARCHAR2)
AS
    v_count int;
    CURSOR c1 IS SELECT r.resname, r.reszipcode, r.resavgreviewscore, r.resavgwaittime 
        FROM restaurant r
        JOIN res_cat rc ON r.resid = rc.resid
        JOIN category c ON rc.catid = c.catid
        WHERE LOWER(c.catname) LIKE '%' || LOWER(p_category_name) || '%'
        AND r.resstatus = 'open';
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM restaurant r
    JOIN res_cat rc ON r.resid = rc.resid
    JOIN category c ON rc.catid = c.catid
    WHERE LOWER(c.catname) LIKE '%' || LOWER(p_category_name) || '%'
    AND r.resstatus = 'open';
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Searching for restaurants under category keyword: ' || p_category_name);
        DBMS_OUTPUT.PUT_LINE('No restaurant under following category'); 
    ELSE
        DBMS_OUTPUT.PUT_LINE('Searching for restaurants under category: ' || p_category_name);
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('| Restaurant Name  | Zip Code | Avg Review Score | Ave Waiting Time (mins) |');
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
        FOR r IN c1 LOOP
            EXIT WHEN c1%notfound;
            DBMS_OUTPUT.PUT_LINE('| ' || RPAD(r.resname, 16) || ' | ' || RPAD(r.reszipcode, 8) || ' | ' || RPAD(r.resavgreviewscore, 17) || ' | ' || RPAD(r.resavgwaittime, 24) || ' |');
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
        END LOOP;
    END IF;
END;
/ 

--regular code1
exec srch_res_by_cat ('food');

--regular code2
exec srch_res_by_cat ('meri');

--special case; 0 result
exec srch_res_by_cat ('asian');
