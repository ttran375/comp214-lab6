ALTER TABLE bb_basketitem ADD CONSTRAINT bitems_qty_ck CHECK (quantity < 20);

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
    WHEN VALUE_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('Check Quantity');
  END;
END;
