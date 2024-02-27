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
 -- Variables to hold input data
  v_donor_type    dd_donor.typecode%TYPE;
  v_pledge_amount dd_pledge.pledgeamt%TYPE;
 -- Cursor declaration
  CURSOR c_pledges IS
  SELECT
    d.Firstname
    || ' '
    || d.Lastname AS donor_name,
    p.Pledgeamt
  FROM
    dd_donor  d
    JOIN dd_pledge p
    ON d.idDonor = p.idDonor
  WHERE
    d.Typecode = v_donor_type
    AND p.Pledgeamt > v_pledge_amount;
BEGIN
 -- Input data
  v_donor_type := 'I'; -- Individual
  v_pledge_amount := 250;
 -- Output header
  DBMS_OUTPUT.PUT_LINE('Donor Name | Pledge Amount');
  DBMS_OUTPUT.PUT_LINE('---------------------------');
 -- Cursor loop
  FOR pledge_rec IN c_pledges LOOP
    DBMS_OUTPUT.PUT_LINE(pledge_rec.donor_name
                         || ' | '
                         || pledge_rec.Pledgeamt);
  END LOOP;
END;
/
