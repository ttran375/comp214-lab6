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

-- Declare a block
DECLARE
  -- Declare a variable to hold the old basket ID and initialize it to 30
  lv_old_num NUMBER := 30;
  
  -- Declare a variable to hold the new basket ID and initialize it to 4
  lv_new_num NUMBER := 4;
  
  -- Declare a variable to hold the count of items with the old basket ID
  lv_count NUMBER;

-- Begin the execution block
BEGIN
  -- Select the count of items from the 'bb_basketitem' table where 'idBasket' equals the value of 'lv_old_num'
  -- Store the result in 'lv_count'
  SELECT
    COUNT(*) INTO lv_count
  FROM
    bb_basketitem
  WHERE
    idBasket = lv_old_num;
    
  -- If no items were found with the old basket ID
  IF lv_count = 0 THEN
    -- Output a message indicating that no items were found
    DBMS_OUTPUT.PUT_LINE('No items found with the original basket ID.');
  -- If items were found with the old basket ID
  ELSE
    -- Update the 'idBasket' column of items in the 'bb_basketitem' table where 'idBasket' equals the value of 'lv_old_num'
    -- Set 'idBasket' to the value of 'lv_new_num'
    UPDATE bb_basketitem
    SET
      idBasket = lv_new_num
    WHERE
      idBasket = lv_old_num;
  -- End the IF statement
  END IF;
  
-- Handle exceptions
EXCEPTION
  -- If no data was found (i.e., there is no basket with the ID stored in 'lv_old_num'), then handle the exception
  WHEN NO_DATA_FOUND THEN
    -- Output a message indicating that the original basket ID is invalid
    DBMS_OUTPUT.PUT_LINE('Invalid original basket ID');
-- End the execution block
END;
