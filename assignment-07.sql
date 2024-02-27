-- Assignment 4-7: Handling Exceptions with User-Defined Errors
-- Sometimes Brewbean’s customers mistakenly leave an item out of a basket that’s already been
-- checked out, so they create a new basket containing the missing items. However, they request
-- FIGURE 4-36 Using the CASE_NOT_FOUND exception handler
-- that the baskets be combined so that they aren’t charged extra shipping. An application page
-- has been developed that enables employees to change the basket ID of items in the
-- BB_BASKETITEM table to another existing basket’s ID to combine the baskets. A block has
-- been constructed to support this page (see the assignment04−07.sql file in the Chapter04
-- folder). However, an exception handler needs to be added to trap the situation of an invalid
-- basket ID being entered for the original basket. In this case, the UPDATE affects no rows but
-- doesn’t raise an Oracle error. The handler should display the message “Invalid original basket
-- ID” onscreen. Use an initialized variable named lv_old_num with a value of 30 and another
-- named lv_new_num with a value of 4 to provide values to the block. First, verify that no item
-- rows with the basket ID 30 exist in the BB_BASKETITEM table.

DECLARE
  -- Declare variables to store the original and new basket IDs, and a count of basket items
  lv_old_num NUMBER := 30;
  lv_new_num NUMBER := 4;
  lv_count NUMBER;
BEGIN
  -- Count the number of items in the bb_basketitem table with the original basket ID
  SELECT
    COUNT(*) INTO lv_count
  FROM
    bb_basketitem
  WHERE
    idBasket = lv_old_num;
    
  -- Check if no items are found with the original basket ID
  IF lv_count = 0 THEN
    -- Output a message indicating no items were found with the original basket ID
    DBMS_OUTPUT.PUT_LINE('No items found with the original basket ID.');
  ELSE
    -- If items are found with the original basket ID, update the basket ID to the new value
    UPDATE bb_basketitem
    SET
      idBasket = lv_new_num
    WHERE
      idBasket = lv_old_num;
  END IF;
EXCEPTION
  -- Exception handling block to catch NO_DATA_FOUND exception
  WHEN NO_DATA_FOUND THEN
    -- Output a message indicating an invalid original basket ID
    DBMS_OUTPUT.PUT_LINE('Invalid original basket ID');
END;
