-- Assignment 4-10: Using a Different Form of Explicit Cursors
-- Redo Assignment 4-9, but use a different cursor form to perform the same task.
DECLARE
  lv_donor_id      NUMBER := 303; -- Specify the donor ID for which you want to retrieve information
  lv_first_payment VARCHAR2(20);
  CURSOR pledge_cursor IS
  SELECT
    p.idPledge,
    p.Pledgeamt,
    p.paymonths,
    py.Paydate,
    py.Payamt
  FROM
    dd_pledge  p
    JOIN dd_payment py
    ON p.idPledge = py.idPledge
  WHERE
    p.idDonor = lv_donor_id
  ORDER BY
    p.idPledge,
    py.Paydate;
BEGIN
  FOR pledge_rec IN pledge_cursor LOOP
 -- Check if it's the first payment for the pledge
    lv_first_payment := CASE
      WHEN pledge_cursor%ROWCOUNT = 1 THEN
        'first payment'
      ELSE
        NULL
    END;
 -- Display the information
    DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                         || pledge_rec.idPledge
                         || ', Pledge Amount: '
                         || pledge_rec.Pledgeamt
                         || ', Pay Months: '
                         || pledge_rec.paymonths
                         || ', Payment Date: '
                         || pledge_rec.Paydate
                         || ', Payment Amount: '
                         || pledge_rec.Payamt
                         || ', '
                         || lv_first_payment);
  END LOOP;
END;
/
