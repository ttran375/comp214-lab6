-- Assignment 4-12: Using a Cursor Variable
-- Create a block with a single cursor that can perform a different query of pledge payment data
-- based on user input. Input provided to the block includes a donor ID and an indicator value of
-- D or S. The D represents details and indicates that each payment on all pledges the donor has
-- made should be displayed. The S indicates displaying summary data of the pledge payment
-- total for each pledge the donor has made.
DECLARE
  v_donor_id       DD_Donor.idDonor%TYPE;
  v_indicator      VARCHAR2(1);
 -- Define cursor variable
  TYPE payment_cursor_type IS
    REF CURSOR;
  v_payment_cursor payment_cursor_type;
 -- Declare variables to store query results
  v_payment_id     DD_Payment.idPay%TYPE;
  v_payment_amt    DD_Payment.Payamt%TYPE;
  v_payment_date   DD_Payment.Paydate%TYPE;
BEGIN
 -- Get user input for donor ID and indicator
  v_donor_id := &donor_id; -- Replace &donor_id with the actual variable to get donor ID from user
  v_indicator := UPPER('&indicator'); -- Replace &indicator with the actual variable to get indicator from user
 -- Open cursor based on user input
  IF v_indicator = 'D' THEN
    OPEN v_payment_cursor FOR
      SELECT
        p.idPay,
        p.Payamt,
        p.Paydate
      FROM
        DD_Payment p
        JOIN DD_Pledge pl
        ON p.idPledge = pl.idPledge
      WHERE
        pl.idDonor = v_donor_id;
  ELSIF v_indicator = 'S' THEN
    OPEN v_payment_cursor FOR
      SELECT
        pl.idPledge,
        SUM(p.Payamt) AS total_payment
      FROM
        DD_Payment p
        JOIN DD_Pledge pl
        ON p.idPledge = pl.idPledge
      WHERE
        pl.idDonor = v_donor_id
      GROUP BY
        pl.idPledge;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Invalid indicator. Please enter D or S.');
    RETURN;
  END IF;
 -- Fetch and display results
  LOOP
    FETCH v_payment_cursor INTO v_payment_id, v_payment_amt, v_payment_date;
    EXIT WHEN v_payment_cursor%NOTFOUND;
    IF v_indicator = 'D' THEN
      DBMS_OUTPUT.PUT_LINE('Payment ID: '
                           || v_payment_id
                           || ', Amount: '
                           || v_payment_amt
                           || ', Date: '
                           || v_payment_date);
    ELSIF v_indicator = 'S' THEN
      DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                           || v_payment_id
                           || ', Total Payment: '
                           || v_payment_amt);
    END IF;
  END LOOP;
 -- Close cursor
  CLOSE v_payment_cursor;
END;
/
