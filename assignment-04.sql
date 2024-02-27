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

-- FIGURE 4-35 Raising an error with a CASE statement
DECLARE
  lv_tax_num NUMBER(2,2);
BEGIN
 CASE  'NJ' 
  WHEN 'VA' THEN lv_tax_num := .04;
  WHEN 'NC' THEN lv_tax_num := .02;  
  WHEN 'NY' THEN lv_tax_num := .06;  
 END CASE;
 DBMS_OUTPUT.PUT_LINE('tax rate = '||lv_tax_num);
END;
/

-- FIGURE 4-36 Using the CASE_NOT_FOUND exception handler
DECLARE
  lv_tax_num NUMBER (2,2);
BEGIN
  CASE 'NJ'
    WHEN 'VA' THEN lv_tax_num := 0.04;
    WHEN 'NO' THEN lv_tax_num := 0.02;
    WHEN 'NY' THEN lv_tax_num := 0.06;
  END CASE;
  
  DBMS_OUTPUT.PUT_LINE('tax rate = ' || lv_tax_num);
EXCEPTION
  WHEN CASE_NOT_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No tax');
END;
