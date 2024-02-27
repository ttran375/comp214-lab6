-- Assignment 4-3: Using Implicit Cursors
-- The BB_SHOPPER table in the Brewbean’s database contains a column named PROMO that
-- specifies promotions to send to shoppers. This column needs to be cleared after the promotion
-- has been sent. First, open the assignment04-03.txt file in the Chapter04 folder in a text
-- editor (such as Notepad). Run the UPDATE and COMMIT statements at the top of this file (not
-- the anonymous block at the end). Modify the anonymous block so that it displays the number of
-- rows updated onscreen. Run the block.

UPDATE bb_shopper
SET
  promo = NULL;

UPDATE bb_shopper
SET
  promo = 'B'
WHERE
  idShopper IN (21, 23, 25);

UPDATE bb_shopper
SET
  promo = 'A'
WHERE
  idShopper = 22;

COMMIT;

DECLARE
 -- Declare a variable to store the number of rows updated
  lv_rows_updated NUMBER;
BEGIN
 -- Update the bb_shopper table
  UPDATE bb_shopper
 -- Set the promo column to NULL where it is not already NULL
  SET
    promo = NULL
  WHERE
    promo IS NOT NULL;
 -- Store the number of rows affected by the update operation
  lv_rows_updated := SQL%ROWCOUNT;
 -- Output the number of rows updated to the console
  DBMS_OUTPUT.PUT_LINE('Number of rows updated: '
                       || lv_rows_updated);
END;
/

-- Query to count the number of rows in bb_shopper where promo is not NULL
SELECT
  COUNT(*)
FROM
  bb_shopper
WHERE
  promo IS NOT NULL;
