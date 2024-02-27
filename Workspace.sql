BEGIN
  BEGIN
    INSERT INTO bb_basketitem VALUES (
      88,
      8,
      10.8,
      21,
      16,
      2,
      3
    );
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -2290 THEN -- Check constraint violation error code
        DBMS_OUTPUT.PUT_LINE('Check Quantity'); -- Display the message
      ELSE
        RAISE; -- Re-raise the exception if it's not the expected check constraint violation
      END IF;
  END;
END;
