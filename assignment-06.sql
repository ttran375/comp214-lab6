-- Assignment 4-6: Handling Exceptions with Undefined Errors
-- Brewbean’s wants to add a check constraint on the QUANTITY column of the
-- BB_BASKETITEM table. If a shopper enters a quantity value greater than 20 for an item,
-- Brewbean’s wants to display the message “Check Quantity” onscreen. Using a text editor, open
-- the assignment04-06.txt file in the Chapter04 folder. The first statement, ALTER TABLE,
-- must be executed to add the check constraint. The next item is a PL/SQL block containing an
-- INSERT action that tests this check constraint. Add code to this block to trap the check
-- constraint violation and display the message.
ALTER TABLE bb_basketitem
  ADD CONSTRAINT bitems_qty_ck CHECK (quantity < 20);

-- Begin the outer block
BEGIN
  -- Begin the inner block
  BEGIN
    -- Attempt to insert a new row into the 'bb_basketitem' table
    -- The values provided violate the 'bitems_qty_ck' check constraint because the 'quantity' value is 21
    INSERT INTO bb_basketitem VALUES (
      88,
      8,
      10.8,
      21, -- This value violates the 'bitems_qty_ck' check constraint
      16,
      2,
      3
    );
  -- Handle exceptions
  EXCEPTION
    -- Catch all exceptions
    WHEN OTHERS THEN
      -- If the error code is -2290, which represents a check constraint violation
      IF SQLCODE = -2290 THEN
        -- Output a message indicating that the 'quantity' value violated the check constraint
        DBMS_OUTPUT.PUT_LINE('Check Quantity');
      -- If the exception is not a check constraint violation
      ELSE
        -- Re-raise the exception
        RAISE;
      END IF;
  -- End the inner block
  END;
-- End the outer block
END;
