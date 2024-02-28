-- Assignment 4-13: Exception Handling
-- The DoGood Donor application contains a page that allows administrators to change the ID
-- assigned to a donor in the DD_DONOR table. Create a PL/SQL block to handle this task.
-- Include exception-handling code to address an error raised by attempting to enter a duplicate
-- donor ID. If this error occurs, display the message “This ID is already assigned.” Test the code
-- by changing donor ID 305. (Don’t include a COMMIT statement; roll back any DML actions used.)

SET SERVEROUTPUT ON;

DECLARE
  lv_old_id dd_donor.idDonor%TYPE := 305; -- Old donor ID
  lv_new_id dd_donor.idDonor%TYPE := 999; -- New donor ID
  lv_row_count NUMBER;
BEGIN
  -- Check if the old ID exists
  SELECT COUNT(*)
  INTO lv_row_count
  FROM dd_donor
  WHERE idDonor = lv_old_id;

  IF lv_row_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No donor with ID ' || lv_old_id || ' found.');
  ELSE
    -- Attempt to change the donor ID
    UPDATE dd_donor
    SET idDonor = lv_new_id
    WHERE idDonor = lv_old_id;
    
    -- Check if any rows were affected by the update
    IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('This ID is already assigned.');
    ELSE
      -- Display success message if the update was successful
      DBMS_OUTPUT.PUT_LINE('Donor ID changed successfully from ' || lv_old_id || ' to ' || lv_new_id);
    END IF;
  END IF;
  
EXCEPTION
  -- Handling other exceptions
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
