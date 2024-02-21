-- Assignment 4-10: Using a Different Form of Explicit Cursors
-- Redo Assignment 4-9, but use a different cursor form to perform the same task.
DECLARE
  vDonorID      NUMBER := 303; -- Specify the donor ID for which you want to retrieve information
  vFirstPayment VARCHAR2(20);
BEGIN
  FOR pledge_rec IN (
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
      p.idDonor = vDonorID
    ORDER BY
      p.idPledge,
      py.Paydate
  ) LOOP
 -- Check if it's the first payment for the pledge
    IF pledge_rec.rownum = 1 THEN
      vFirstPayment := 'first payment';
    ELSE
      vFirstPayment := NULL;
    END IF;
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
                         || vFirstPayment);
  END LOOP;
END;
/

DECLARE
  vDonorID      NUMBER := 303; -- Specify the donor ID for which you want to retrieve information
  vFirstPayment VARCHAR2(20);
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
    p.idDonor = vDonorID
  ORDER BY
    p.idPledge,
    py.Paydate;
BEGIN
  FOR pledge_rec IN pledge_cursor LOOP
 -- Check if it's the first payment for the pledge
    vFirstPayment := CASE
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
                         || vFirstPayment);
  END LOOP;
END;
/
