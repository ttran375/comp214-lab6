-- Assignment 4-9: Using an Explicit Cursor
-- Create a block to retrieve and display pledge and payment information for a specific donor. For
-- each pledge payment from the donor, display the pledge ID, pledge amount, number of monthly
-- payments, payment date, and payment amount. The list should be sorted by pledge ID and then
-- by payment date. For the first payment made for each pledge, display “first payment” on that
-- output row.

DECLARE
 -- Variables to store pledge and payment information
  lv_pledge_id     dd_pledge.idPledge%TYPE;
  lv_pledge_amt    dd_pledge.Pledgeamt%TYPE;
  lv_paymonths     dd_pledge.paymonths%TYPE;
  lv_payment_id    dd_payment.idPay%TYPE;
  lv_payment_date  dd_payment.Paydate%TYPE;
  lv_payment_amt   dd_payment.Payamt%TYPE;
  lv_first_payment VARCHAR2(20);
 -- Cursor declaration
  CURSOR c_pledges IS
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
    pay.Paydate;
BEGIN
 -- Open cursor
  OPEN c_pledges;
 -- Fetching data from cursor
  LOOP
    FETCH c_pledges INTO lv_pledge_id, lv_pledge_amt, lv_paymonths, lv_payment_id, lv_payment_date, lv_payment_amt;
    EXIT WHEN c_pledges%NOTFOUND;
 -- Checking if it's the first payment
    IF lv_payment_id IS NULL THEN
      lv_first_payment := 'First payment';
    ELSE
      lv_first_payment := '';
    END IF;
 -- Displaying pledge and payment information
    DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                         || lv_pledge_id
                         || ', Pledge Amount: '
                         || lv_pledge_amt
                         || ', Number of Monthly Payments: '
                         || lv_paymonths
                         || ', Payment Date: '
                         || lv_payment_date
                         || ', Payment Amount: '
                         || lv_payment_amt
                         || ' '
                         || lv_first_payment);
  END LOOP;
 -- Close cursor
  CLOSE c_pledges;
END;
/
