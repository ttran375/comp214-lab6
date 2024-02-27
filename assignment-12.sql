-- Assignment 4-12: Using a Cursor Variable
-- Create a block with a single cursor that can perform a different query of pledge payment data
-- based on user input. Input provided to the block includes a donor ID and an indicator value of
-- D or S. The D represents details and indicates that each payment on all pledges the donor has
-- made should be displayed. The S indicates displaying summary data of the pledge payment
-- total for each pledge the donor has made.

SET SERVEROUTPUT ON;

DECLARE
    v_donor_id dd_donor.idDonor%TYPE;
    v_indicator CHAR(1) := 'D'; -- Default value for indicator
    v_cursor SYS_REFCURSOR;
    v_payment_amount dd_payment.Payamt%TYPE;
    v_payment_date dd_payment.Paydate%TYPE;
    v_pledge_id dd_pledge.idPledge%TYPE;
BEGIN
    -- Accept user input with default value
    v_donor_id := NVL(&enter_donor_id, v_donor_id);
    v_indicator := UPPER(NVL('&enter_indicator', v_indicator));

    -- Open cursor
    IF v_indicator = 'D' THEN
        OPEN v_cursor FOR
            SELECT p.idPledge, py.Payamt, py.Paydate
            FROM dd_pledge p
            JOIN dd_payment py ON p.idPledge = py.idPledge
            WHERE p.idDonor = v_donor_id;
    ELSIF v_indicator = 'S' THEN
        OPEN v_cursor FOR
            SELECT p.idPledge, SUM(py.Payamt)
            FROM dd_pledge p
            JOIN dd_payment py ON p.idPledge = py.idPledge
            WHERE p.idDonor = v_donor_id
            GROUP BY p.idPledge;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid indicator. Please enter D or S.');
        RETURN;
    END IF;

    -- Fetch and display data
    LOOP
        FETCH v_cursor INTO v_pledge_id, v_payment_amount, v_payment_date;
        EXIT WHEN v_cursor%NOTFOUND;

        IF v_indicator = 'D' THEN
            DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || v_pledge_id || ', Payment Amount: ' || v_payment_amount || ', Payment Date: ' || v_payment_date);
        ELSIF v_indicator = 'S' THEN
            DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || v_pledge_id || ', Total Payment Amount: ' || v_payment_amount);
        END IF;
    END LOOP;

    -- Close cursor
    CLOSE v_cursor;
END;
/
