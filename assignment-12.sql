-- Assignment 4-12: Using a Cursor Variable
-- Create a block with a single cursor that can perform a different query of pledge payment data
-- based on user input. Input provided to the block includes a donor ID and an indicator value of
-- D or S. The D represents details and indicates that each payment on all pledges the donor has
-- made should be displayed. The S indicates displaying summary data of the pledge payment
-- total for each pledge the donor has made.
DECLARE
  lv_donor_id       DD_Donor.idDonor%TYPE;
  lv_indicator      VARCHAR2(1);
 -- Define cursor variable
  TYPE payment_cursor_type IS
    REF CURSOR;
  lv_payment_cursor payment_cursor_type;
 -- Declare variables to store query results
  lv_payment_id     DD_Payment.idPay%TYPE;
  lv_payment_amt    DD_Payment.Payamt%TYPE;
  lv_payment_date   DD_Payment.Paydate%TYPE;
BEGIN
 -- Get user input for donor ID and indicator
  lv_donor_id := &donor_id; -- Replace &donor_id with the actual variable to get donor ID from user
  lv_indicator := UPPER('&indicator'); -- Replace &indicator with the actual variable to get indicator from user
 -- Open cursor based on user input
  IF lv_indicator = 'D' THEN
    OPEN lv_payment_cursor FOR
      SELECT
        p.idPay,
        p.Payamt,
        p.Paydate
      FROM
        DD_Payment p
        JOIN DD_Pledge pl
        ON p.idPledge = pl.idPledge
      WHERE
        pl.idDonor = lv_donor_id;
  ELSIF lv_indicator = 'S' THEN
    OPEN lv_payment_cursor FOR
      SELECT
        pl.idPledge,
        SUM(p.Payamt) AS total_payment
      FROM
        DD_Payment p
        JOIN DD_Pledge pl
        ON p.idPledge = pl.idPledge
      WHERE
        pl.idDonor = lv_donor_id
      GROUP BY
        pl.idPledge;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Invalid indicator. Please enter D or S.');
    RETURN;
  END IF;
 -- Fetch and display results
  LOOP
    FETCH lv_payment_cursor INTO lv_payment_id, lv_payment_amt, lv_payment_date;
    EXIT WHEN lv_payment_cursor%NOTFOUND;
    IF lv_indicator = 'D' THEN
      DBMS_OUTPUT.PUT_LINE('Payment ID: '
                           || lv_payment_id
                           || ', Amount: '
                           || lv_payment_amt
                           || ', Date: '
                           || lv_payment_date);
    ELSIF lv_indicator = 'S' THEN
      DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                           || lv_payment_id
                           || ', Total Payment: '
                           || lv_payment_amt);
    END IF;
  END LOOP;
 -- Close cursor
  CLOSE lv_payment_cursor;
END;
/
