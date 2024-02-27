-- Assignment 4-2: Using a CURSOR FOR Loop
-- Brewbean’s wants to send a promotion via e-mail to shoppers. A shopper who has purchased
-- more than $50 at the site receives a $5 coupon for his or her next purchase over $25. A
-- shopper who has spent more than $100 receives a free shipping coupon.
-- The BB_SHOPPER table contains a column named PROMO for storing promotion codes.
-- Follow the steps to create a block with a CURSOR FOR loop to check the total spent by each
-- shopper and update the PROMO column in the BB_SHOPPER table accordingly. The cursor’s
-- SELECT statement contains a subquery in the FROM clause to retrieve the shopper totals
-- because a cursor using a GROUP BY statement can’t use the FOR UPDATE clause. Its results are
-- summarized data rather than separate rows from the database.
-- 1. In SQL Developer, open the assignment04-02.sql file in the Chapter04 folder.
-- 2. Run the block. Notice the subquery in the SELECT statement. Also, because an UPDATE is
-- performed, the FOR UPDATE and WHERE CURRENT OF clauses are used.
-- 3. Run a query, as shown in Figure 4-34, to check the results.

-- Declare a block
DECLARE
 -- Declare a cursor to select shopper IDs, their promo status, and their total basket value
  CURSOR cur_shopper IS
  SELECT
    a.idShopper,
    a.promo,
    b.total
  FROM
    bb_shopper a,
    (
 -- Subquery to calculate the total value of each shopper's basket
      SELECT
        b.idShopper,
        SUM(bi.quantity*bi.price) total
      FROM
        bb_basketitem bi,
        bb_basket     b
      WHERE
        bi.idBasket = b.idBasket
      GROUP BY
        idShopper
    )          b
  WHERE
    a.idShopper = b.idShopper FOR UPDATE OF a.idShopper NOWAIT; -- Lock the rows for update
 -- Declare a variable to hold the promo status
  lv_promo_txt CHAR(1);
 -- Begin the execution block
BEGIN
 -- Loop through each row returned by the cursor
  FOR rec_shopper IN cur_shopper LOOP
 -- Initialize the promo status to 'X'
    lv_promo_txt := 'X';
 -- If the total basket value is greater than 100, set the promo status to 'A'
    IF rec_shopper.total > 100 THEN
      lv_promo_txt := 'A';
    END IF;
 -- If the total basket value is between 50 and 99, set the promo status to 'B'
    IF rec_shopper.total BETWEEN 50 AND 99 THEN
      lv_promo_txt := 'B';
    END IF;
 -- If the promo status is not 'X', update the promo status in the bb_shopper table
    IF lv_promo_txt <> 'X' THEN
      UPDATE bb_shopper
      SET
        promo = lv_promo_txt
      WHERE
        CURRENT OF cur_shopper; -- Update the current row of the cursor
    END IF;
  END LOOP;
 -- Commit the changes
  COMMIT;
END;
/

-- Query to check the promo status and total basket value of each shopper
SELECT
  idShopper,
  s.promo,
  SUM(bi.quantity*bi.price) total
FROM
  bb_shopper    s
  INNER JOIN bb_basket b
  USING (idShopper)
  INNER JOIN bb_basketitem bi
  USING (idBasket)
GROUP BY
  idShopper,
  s.promo
ORDER BY
  idShopper;
