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

-- Declare a block
DECLARE
 -- Declare a cursor to select basket items and their corresponding stock
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
 -- Declare a record type to hold the basket item and stock information
  TYPE type_basket IS RECORD (
    basket bb_basketitem.idBasket%TYPE,
    qty bb_basketitem.quantity%TYPE,
    stock bb_product.stock%TYPE
  );
 -- Declare a record variable of the above type
  rec_basket  type_basket;
 -- Declare and initialize a flag variable to 'Y'
  lv_flag_txt CHAR(1) := 'Y';
 -- Begin the execution block
BEGIN
 -- Open the cursor
  OPEN cur_basket;
 -- Start a loop to fetch rows from the cursor
  LOOP
 -- Fetch the next row from the cursor into the record variable
    FETCH cur_basket INTO rec_basket;
 -- Exit the loop if there are no more rows
    EXIT WHEN cur_basket%NOTFOUND;
 -- If the stock is less than the quantity, set the flag to 'N'
    IF rec_basket.stock < rec_basket.qty THEN
      lv_flag_txt := 'N';
    END IF;
  END LOOP;
 -- Close the cursor
  CLOSE cur_basket;
 -- If the flag is 'Y', output a message indicating all items are in stock
  IF lv_flag_txt = 'Y' THEN
    DBMS_OUTPUT.PUT_LINE('All items in stock!');
  END IF;
 -- If the flag is 'N', output a message indicating not all items are in stock
  IF lv_flag_txt = 'N' THEN
    DBMS_OUTPUT.PUT_LINE('All items NOT in stock!');
  END IF;
 -- End the execution block
END;
