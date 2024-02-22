DECLARE
  ex_prod_update EXCEPTION;
BEGIN
  UPDATE bb_product
  SET
    description = 'Mill grinder with 5 grind settings!'
  WHERE
    idProduct = 30;
  IF SQL%NOTFOUND THEN
    RAISE ex_prod_update;
  END IF;
EXCEPTION
  WHEN ex_prod_update THEN
    DBMS_OUTPUT.PUT_LINE('Invalid product ID entered');
END;
/

DECLARE
  TYPE type_basket IS RECORD (
    basket bb_basket.idBasket%TYPE,
    created bb_basket.dtcreated%TYPE,
    qty bb_basket.quantity%TYPE,
    sub bb_basket.subtotal%TYPE
  );
  rec_basket     type_basket;
  lv_days_num    NUMBER(3);
  lv_shopper_num NUMBER(3) := 26;
BEGIN
  SELECT
    idBasket,
    dtcreated,
    quantity,
    subtotal INTO rec_basket
  FROM
    bb_basket
  WHERE
    idShopper = lv_shopper_num
    AND orderplaced = 0;
  lv_days_num := SYSDATE - rec_basket.created;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('You have no saved baskets!');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('A problem has occurred.');
    DBMS_OUTPUT.PUT_LINE('Tech Support will be notified and
will contact you via e-mail.');
END;
/
