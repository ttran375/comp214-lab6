-- Assignment 4-4: Using Exception Handling
-- In this assignment, you test a block containing a CASE statement for errors, and then add an
-- exception handler for a predefined exception:
-- 1. In Notepad, open the assignment04-04.sql file in the Chapter04 folder. Review the
-- block, which contains a CASE statement and no exception handlers.
-- 2. Copy and paste the block into SQL Developer, and run the block. Your results should
-- look like Figure 4-35. An error is raised because the state of NJ isn’t included in the CASE
-- statement; recall that a CASE statement must find a matching case.
-- 3. To correct this problem, add a predefined EXCEPTION handler that addresses this error
-- and displays “No tax” onscreen.
-- 4. Run the block again. Your results should look like Figure 4-36. Now the error is handled in
-- the block’s EXCEPTION section.
DECLARE
   CURSOR cur_basket IS
     SELECT bi.idBasket, bi.quantity, p.stock
       FROM bb_basketitem bi INNER JOIN bb_product p
         USING (idProduct)
       WHERE bi.idBasket = 6;
   TYPE type_basket IS RECORD (
     basket bb_basketitem.idBasket%TYPE,
     qty bb_basketitem.quantity%TYPE,
     stock bb_product.stock%TYPE);
   rec_basket type_basket;
   lv_flag_txt CHAR(1) := 'Y';
BEGIN
   OPEN cur_basket;
   LOOP 
     FETCH cur_basket INTO rec_basket;
      EXIT WHEN cur_basket%NOTFOUND;
      IF rec_basket.stock < rec_basket.qty THEN lv_flag_txt := 'N'; END IF;
   END LOOP;
   CLOSE cur_basket;
   IF lv_flag_txt = 'Y' THEN DBMS_OUTPUT.PUT_LINE('All items in stock!'); END IF;
   IF lv_flag_txt = 'N' THEN DBMS_OUTPUT.PUT_LINE('All items NOT in stock!'); END IF;   
END;
/

-- FIGURE 4-35 Raising an error with a CASE statement
DECLARE
  lv_tax_num NUMBER (2,2);
BEGIN
  CASE 'NJ'
    WHEN 'VA' THEN lv_tax_num := .04;
    WHEN 'NO' THEN lv_tax_num := .02;
    WHEN 'NY' THEN lv_tax_num := .06;
    -- Add a clause for 'NJ'
    WHEN 'NJ' THEN lv_tax_num := .05; -- Replace .05 with the actual tax rate for NJ
    ELSE lv_tax_num := .00; -- Default case
  END CASE;
  DBMS_OUTPUT.PUT_LINE('tax rate = ' || lv_tax_num);
END;
