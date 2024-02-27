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
