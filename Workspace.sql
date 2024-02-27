-- Assignment 4-5: Handling Predefined Exceptions
-- A block of code has been created to retrieve basic customer information (see the
-- assignment04-05.sql file in the Chapter04 folder). The application page was modified so
-- that an employee can enter a customer number that could cause an error. An exception handler
-- needs to be added to the block that displays the message “Invalid shopper ID” onscreen. Use
-- an initialized variable named lv_shopper_num to provide a shopper ID. Test the block with the
-- shopper ID 99.
DECLARE
  rec_shopper    bb_shopper%ROWTYPE;
  lv_shopper_num bb_shopper.idShopper%TYPE := 99; -- Initialize lv_shopper_num with the shopper ID
BEGIN
  BEGIN
    SELECT
      * INTO rec_shopper
    FROM
      bb_shopper
    WHERE
      idShopper = lv_shopper_num;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Invalid shopper ID');
  END;
END;
