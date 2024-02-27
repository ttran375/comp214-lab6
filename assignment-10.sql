-- Assignment 4-10: Using a Different Form of Explicit Cursors
-- Redo Assignment 4-9, but use a different cursor form to perform the same task.

DECLARE
  -- Variables to store pledge and payment information
  lv_first_payment VARCHAR2(20);
BEGIN
  -- Cursor declaration using cursor FOR loop
  FOR pledge_rec IN (
    SELECT
      p.idPledge,
      p.Pledgeamt,
      p.paymonths,
      pay.idPay,
      pay.Paydate,
      pay.Payamt
    FROM
      dd_pledge  p
      LEFT JOIN dd_payment pay
      ON p.idPledge = pay.idPledge
    WHERE
      p.idDonor = 301 -- Change this to the specific donor ID you want to retrieve information for
    ORDER BY
      p.idPledge,
      pay.Paydate
  )
  LOOP
    -- Checking if it's the first payment
    IF pledge_rec.idPay IS NULL THEN
      lv_first_payment := 'First payment';
    ELSE
      lv_first_payment := '';
    END IF;
    -- Displaying pledge and payment information
    DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                         || pledge_rec.idPledge
                         || ', Pledge Amount: '
                         || pledge_rec.Pledgeamt
                         || ', Number of Monthly Payments: '
                         || pledge_rec.paymonths
                         || ', Payment Date: '
                         || pledge_rec.Paydate
                         || ', Payment Amount: '
                         || pledge_rec.Payamt
                         || ' '
                         || lv_first_payment);
  END LOOP;
END;
