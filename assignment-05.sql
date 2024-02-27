-- Assignment 4-5: Handling Predefined Exceptions
-- A block of code has been created to retrieve basic customer information (see the
-- assignment04-05.sql file in the Chapter04 folder). The application page was modified so
-- that an employee can enter a customer number that could cause an error. An exception handler
-- needs to be added to the block that displays the message “Invalid shopper ID” onscreen. Use
-- an initialized variable named lv_shopper_num to provide a shopper ID. Test the block with the
-- shopper ID 99.
-- Declare a block
DECLARE
  -- Declare a record variable of type 'bb_shopper'
  rec_shopper    bb_shopper%ROWTYPE;
  
  -- Declare a variable to hold the shopper ID and initialize it to 99
  lv_shopper_num bb_shopper.idShopper%TYPE := 99;

-- Begin the execution block
BEGIN
  -- Begin an inner block
  SELECT
      * INTO rec_shopper
    FROM
      bb_shopper
    WHERE
      idShopper = lv_shopper_num;
      
  -- Handle exceptions
  EXCEPTION
    -- If no data was found (i.e., there is no shopper with the ID stored in 'lv_shopper_num'), then handle the exception
    WHEN NO_DATA_FOUND THEN
      -- Output a message indicating that the shopper ID is invalid
      DBMS_OUTPUT.PUT_LINE('Invalid shopper ID');
  
-- End the execution block
END;
