-- Assignment 4-13: Exception Handling
-- The DoGood Donor application contains a page that allows administrators to change the ID
-- assigned to a donor in the DD_DONOR table. Create a PL/SQL block to handle this task.
-- Include exception-handling code to address an error raised by attempting to enter a duplicate
-- donor ID. If this error occurs, display the message “This ID is already assigned.” Test the code
-- by changing donor ID 305. (Don’t include a COMMIT statement; roll back any DML actions used.)
DECLARE
  lv_old_donor_id DD_Donor.idDonor%TYPE := 305; -- Old donor ID to change
  lv_new_donor_id DD_Donor.idDonor%TYPE := 999; -- New donor ID
BEGIN
 -- Attempt to change donor ID
  BEGIN
    UPDATE DD_Donor
    SET
      idDonor = lv_new_donor_id
    WHERE
      idDonor = lv_old_donor_id;
    DBMS_OUTPUT.PUT_LINE('Donor ID changed successfully.');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      DBMS_OUTPUT.PUT_LINE('This ID is already assigned.');
  END;
 -- Display updated donor information
  FOR donor_rec IN (
    SELECT
      *
    FROM
      DD_Donor
    WHERE
      idDonor = lv_new_donor_id
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('New Donor ID: '
                         || donor_rec.idDonor
                         || ', Name: '
                         || donor_rec.Firstname
                         || ' '
                         || donor_rec.Lastname);
  END LOOP;
 -- Rollback any changes
  ROLLBACK;
END;
