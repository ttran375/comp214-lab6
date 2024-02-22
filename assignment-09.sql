-- Assignment 4-9: Using an Explicit Cursor
-- Create a block to retrieve and display pledge and payment information for a specific donor. For
-- each pledge payment from the donor, display the pledge ID, pledge amount, number of monthly
-- payments, payment date, and payment amount. The list should be sorted by pledge ID and then
-- by payment date. For the first payment made for each pledge, display “first payment” on that
-- output row.
DECLARE
  vDonorID       NUMBER := 303;
  vPledgeID      dd_pledge.idPledge%TYPE;
  vPledgeAmt     dd_pledge.Pledgeamt%TYPE;
  vPayMonths     dd_pledge.paymonths%TYPE;
  vPaymentDate   dd_payment.Paydate%TYPE;
  vPaymentAmount dd_payment.Payamt%TYPE;
  vFirstPayment  VARCHAR2(20);
  vCounter       NUMBER := 0;
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
    vCounter := vCounter + 1;
    vPledgeID := pledge_rec.idPledge;
    vPledgeAmt := pledge_rec.Pledgeamt;
    vPayMonths := pledge_rec.paymonths;
    vPaymentDate := pledge_rec.Paydate;
    vPaymentAmount := pledge_rec.Payamt;
    IF vCounter = 1 THEN
      vFirstPayment := 'first payment';
    ELSE
      vFirstPayment := NULL;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                         || vPledgeID
                         || ', Pledge Amount: '
                         || vPledgeAmt
                         || ', Pay Months: '
                         || vPayMonths
                         || ', Payment Date: '
                         || vPaymentDate
                         || ', Payment Amount: '
                         || vPaymentAmount
                         || ', '
                         || vFirstPayment);
  END LOOP;
END;
