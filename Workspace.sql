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

BEGIN
  UPDATE bb_shopper
  SET
    promo = NULL
  WHERE
    promo IS NOT NULL;
END;
/

DECLARE
  lv_rows_updated NUMBER;
BEGIN
 -- Update the PROMO column and capture the number of rows updated
  UPDATE bb_shopper
  SET
    promo = NULL
  WHERE
    promo IS NOT NULL;
 -- Get the number of rows updated
  lv_rows_updated := SQL%ROWCOUNT;
 -- Display the number of rows updated
  DBMS_OUTPUT.PUT_LINE('Number of rows updated: '
                       || lv_rows_updated);
END;

-- There are indeed no rows where promo is not NULL, and thus, the update 
-- statement will not affect any rows
SELECT
  COUNT(*)
FROM
  bb_shopper
WHERE
  promo IS NOT NULL;
