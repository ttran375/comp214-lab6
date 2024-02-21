DECLARE
  v_old_donor_id DD_Donor.idDonor%TYPE := 305; -- Old donor ID to change
  v_new_donor_id DD_Donor.idDonor%TYPE := 999; -- New donor ID
BEGIN
 -- Attempt to change donor ID
  BEGIN
    UPDATE DD_Donor
    SET
      idDonor = v_new_donor_id
    WHERE
      idDonor = v_old_donor_id;
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
      idDonor = v_new_donor_id
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
/
