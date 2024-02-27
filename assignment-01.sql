-- Assignment 4-1: Using an Explicit Cursor
-- In the Brewbean’s application, a customer can ask to check whether all items in his or her
-- basket are in stock. In this assignment, you create a block that uses an explicit cursor to
-- retrieve all items in the basket and determine whether all items are in stock by comparing the
-- item quantity with the product stock amount. If all items are in stock, display the message
-- “All items in stock!” onscreen. If not, display the message “All items NOT in stock!” onscreen.
-- The basket number is provided with an initialized variable. Follow these steps:
-- 1. In SQL Developer, open the assignment04-01.sql file in the Chapter04 folder.
-- 2. Run the block. Notice that both a cursor and a record variable are created in the DECLARE
-- section. The cursor must be manipulated with explicit actions of OPEN, FETCH, and CLOSE.
-- A variable named lv_flag_txt is used to store the status of the stock check. The results
-- should look like Figure 4-33.
DECLARE
  CURSOR cur_basket IS
  SELECT
    bi.idBasket,
    bi.quantity,
    p.stock
  FROM
    bb_basketitem bi
    INNER JOIN bb_product p
    USING(idProduct)
  WHERE
    bi.idBasket = 6;
  TYPE type_basket IS RECORD (
    basket bb_basketitem.idBasket%TYPE,
    qty bb_basketitem.quantity%TYPE,
    stock bb_product.stock%TYPE
  );
  rec_basket  type_basket;
  lv_flag_txt CHAR(1) := 'Y';
BEGIN
  OPEN cur_basket;
  LOOP
    FETCH cur_basket INTO rec_basket;
    EXIT WHEN cur_basket%NOTFOUND;
    IF rec_basket.stock < rec_basket.qty THEN
      lv_flag_txt := 'N';
    END IF;
  END LOOP;

  CLOSE cur_basket;
  IF lv_flag_txt = 'Y' THEN
    DBMS_OUTPUT.PUT_LINE('All items in stock!');
  END IF;

  IF lv_flag_txt = 'N' THEN
    DBMS_OUTPUT.PUT_LINE('All items NOT in stock!');
  END IF;
END;
