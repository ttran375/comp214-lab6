-- Assignment 4-6: Handling Exceptions with Undefined Errors
-- Brewbean’s wants to add a check constraint on the QUANTITY column of the
-- BB_BASKETITEM table. If a shopper enters a quantity value greater than 20 for an item,
-- Brewbean’s wants to display the message “Check Quantity” onscreen. Using a text editor, open
-- the assignment04-06.txt file in the Chapter04 folder. The first statement, ALTER TABLE,
-- must be executed to add the check constraint. The next item is a PL/SQL block containing an
-- INSERT action that tests this check constraint. Add code to this block to trap the check
-- constraint violation and display the message.
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
