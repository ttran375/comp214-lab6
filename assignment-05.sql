-- Assignment 4-5: Handling Predefined Exceptions
-- A block of code has been created to retrieve basic customer information (see the
-- assignment04-05.sql file in the Chapter04 folder). The application page was modified so
-- that an employee can enter a customer number that could cause an error. An exception handler
-- needs to be added to the block that displays the message “Invalid shopper ID” onscreen. Use
-- an initialized variable named lv_shopper_num to provide a shopper ID. Test the block with the
-- shopper ID 99.

DECLARE
  -- Declare a record variable to store data from the bb_shopper table
  rec_shopper    bb_shopper%ROWTYPE;
  -- Declare a variable to store the shopper ID, initialized to 99
  lv_shopper_num bb_shopper.idShopper%TYPE := 99;

BEGIN
  -- Attempt to select a record from the bb_shopper table where the idShopper matches lv_shopper_num
  SELECT
      * INTO rec_shopper
    FROM
      bb_shopper
    WHERE
      idShopper = lv_shopper_num;

  -- Exception handling block
  EXCEPTION
    -- If no data is found for the specified shopper ID, handle the NO_DATA_FOUND exception
    WHEN NO_DATA_FOUND THEN
      -- Output a message indicating that the shopper ID is invalid
      DBMS_OUTPUT.PUT_LINE('Invalid shopper ID');

END;
