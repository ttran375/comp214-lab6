-- Assignment 4-9: Using an Explicit Cursor
-- Create a block to retrieve and display pledge and payment information for a specific donor. For
-- each pledge payment from the donor, display the pledge ID, pledge amount, number of monthly
-- payments, payment date, and payment amount. The list should be sorted by pledge ID and then
-- by payment date. For the first payment made for each pledge, display “first payment” on that
-- output row.

DECLARE
 -- Declare variables to store donor information, pledge details, and payment details
  lv_donor_id       NUMBER := 303;
  lv_pledge_id      dd_pledge.idPledge%TYPE;
  lv_pledge_amt     dd_pledge.Pledgeamt%TYPE;
  lv_pay_months     dd_pledge.paymonths%TYPE;
  lv_payment_date   dd_payment.Paydate%TYPE;
  lv_payment_amount dd_payment.Payamt%TYPE;
  lv_first_payment  VARCHAR2(20);
  lv_counter        NUMBER := 0;
 -- Cursor to select pledge and payment details for the specified donor
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
 -- Loop through each pledge and its corresponding payments
  FOR pledge_rec IN pledge_cursor LOOP
 -- Increment the counter for each pledge
    lv_counter := lv_counter + 1;
 -- Assign pledge details to variables
    lv_pledge_id := pledge_rec.idPledge;
    lv_pledge_amt := pledge_rec.Pledgeamt;
    lv_pay_months := pledge_rec.paymonths;
 -- Assign payment details to variables
    lv_payment_date := pledge_rec.Paydate;
    lv_payment_amount := pledge_rec.Payamt;
 -- Determine if it's the first payment for the pledge
    IF lv_counter = 1 THEN
      lv_first_payment := 'first payment';
    ELSE
      lv_first_payment := NULL;
    END IF;
 -- Output pledge and payment details along with whether it's the first payment
    DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                         || lv_pledge_id
                         || ', Pledge Amount: '
                         || lv_pledge_amt
                         || ', Pay Months: '
                         || lv_pay_months
                         || ', Payment Date: '
                         || lv_payment_date
                         || ', Payment Amount: '
                         || lv_payment_amount
                         || ', '
                         || lv_first_payment);
  END LOOP;
END;
