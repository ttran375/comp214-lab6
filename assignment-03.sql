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
/

-- Begin PL/SQL anonymous block
BEGIN
  -- Update the 'promo' column of all rows in the 'bb_shopper' table where 'promo' is not NULL to NULL
  UPDATE bb_shopper
  SET
    promo = NULL
  WHERE
    promo IS NOT NULL;
-- End PL/SQL anonymous block
END;
/

-- Declare a PL/SQL anonymous block
DECLARE
  -- Declare a variable to hold the number of rows updated
  lv_rows_updated NUMBER;
BEGIN
 -- Update the 'promo' column of all rows in the 'bb_shopper' table where 'promo' is not NULL to NULL
  UPDATE bb_shopper
  SET
    promo = NULL
  WHERE
    promo IS NOT NULL;
 -- Get the number of rows updated by the last SQL statement
  lv_rows_updated := SQL%ROWCOUNT;
 -- Display the number of rows updated
  DBMS_OUTPUT.PUT_LINE('Number of rows updated: '
                       || lv_rows_updated);
-- End PL/SQL anonymous block
END;
/

-- There are indeed no rows where promo is not NULL, and thus, the update
-- statement will not affect any rows
SELECT
  COUNT(*)
FROM
  bb_shopper
WHERE
  promo IS NOT NULL;
