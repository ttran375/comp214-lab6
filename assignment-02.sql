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
DECLARE
  CURSOR cur_shopper IS
  SELECT
    a.idShopper,
    a.promo,
    b.total
  FROM
    bb_shopper a,
    (
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
    a.idShopper = b.idShopper FOR UPDATE OF a.idShopper NOWAIT;
  lv_promo_txt CHAR(1);
BEGIN
  FOR rec_shopper IN cur_shopper LOOP
    lv_promo_txt := 'X';
    IF rec_shopper.total > 100 THEN
      lv_promo_txt := 'A';
    END IF;

    IF rec_shopper.total BETWEEN 50 AND 99 THEN
      lv_promo_txt := 'B';
    END IF;

    IF lv_promo_txt <> 'X' THEN
      UPDATE bb_shopper
      SET
        promo = lv_promo_txt
      WHERE
        CURRENT OF cur_shopper;
    END IF;
  END LOOP;

  COMMIT;
END;
/

-- FIGURE 4-34 Querying the BB_SHOPPER table to check the PROMO column
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
