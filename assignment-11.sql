-- Assignment 4-11: Adding Cursor Flexibility
-- An administration page in the DoGood Donor application allows employees to enter multiple
-- combinations of donor type and pledge amount to determine data to retrieve. Create a block
-- with a single cursor that allows retrieving data and handling multiple combinations of donor type
-- and pledge amount as input. The donor name and pledge amount should be retrieved and
-- displayed for each pledge that matches the donor type and is greater than the pledge amount
-- indicated. Use a collection to provide the input data. Test the block using the following input
-- data. Keep in mind that these inputs should be processed with one execution of the block. The
-- donor type code I represents Individual, and B represents Business.
-- Donor Type < Pledge Amount
-- I 250
-- B 500
DECLARE
 -- Declare variables
  v_donor_type    CHAR(1);
  v_pledge_amount NUMBER(8, 2);
BEGIN
 -- Set donor type and pledge amount
  v_donor_type := 'I'; -- Individual
  v_pledge_amount := 250;
 -- Use a cursor to retrieve data based on donor type and pledge amount
  FOR pledge_rec IN (
    SELECT
      d.Firstname
      || ' '
      || d.Lastname AS donor_name,
      p.Pledgedate,
      p.Pledgeamt
    FROM
      DD_Donor  d
      JOIN DD_Pledge p
      ON d.idDonor = p.idDonor
    WHERE
      d.Typecode = v_donor_type
      AND p.Pledgeamt > v_pledge_amount
  ) LOOP
 -- Display retrieved data
    DBMS_OUTPUT.PUT_LINE('Donor Name: '
                         || pledge_rec.donor_name);
    DBMS_OUTPUT.PUT_LINE('Pledge Date: '
                         || pledge_rec.Pledgedate);
    DBMS_OUTPUT.PUT_LINE('Pledge Amount: '
                         || pledge_rec.Pledgeamt);
    DBMS_OUTPUT.PUT_LINE('--------------------------');
  END LOOP;
END;
/
