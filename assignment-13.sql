-- Assignment 4-13: Exception Handling
-- The DoGood Donor application contains a page that allows administrators to change the ID
-- assigned to a donor in the DD_DONOR table. Create a PL/SQL block to handle this task.
-- Include exception-handling code to address an error raised by attempting to enter a duplicate
-- donor ID. If this error occurs, display the message “This ID is already assigned.” Test the code
-- by changing donor ID 305. (Don’t include a COMMIT statement; roll back any DML actions used.)

SET SERVEROUTPUT ON;

DECLARE
  v_old_id dd_donor.idDonor%TYPE := 305; -- Old donor ID
  v_new_id dd_donor.idDonor%TYPE := 999; -- New donor ID
BEGIN
  -- Attempt to change the donor ID
  UPDATE dd_donor
  SET idDonor = v_new_id
  WHERE idDonor = v_old_id;
  
  -- Display success message if no exceptions are raised
  DBMS_OUTPUT.PUT_LINE('Donor ID changed successfully from ' || v_old_id || ' to ' || v_new_id);
  
EXCEPTION
  -- Handling duplicate donor ID exception
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('This ID is already assigned.');
  
  -- Handling other exceptions
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
