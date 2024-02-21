-- Case Projects

-- Case 4-1: Using Exception Handlers in the Brewbean’s Application
-- A new part-time programming employee has been reviewing some PL/SQL code you
-- developed. The following two blocks contain a variety of exception handlers. Explain the
-- different types for the new employee.
-- Block 1:
-- DECLARE
-- ex_prod_update EXCEPTION;
-- BEGIN
-- UPDATE bb_product
-- SET description = 'Mill grinder with 5 grind settings!'
-- WHERE idProduct = 30;
-- IF SQL%NOTFOUND THEN
-- RAISE ex_prod_update;
-- END IF;
-- EXCEPTION
-- WHEN ex_prod_update THEN
-- DBMS_OUTPUT.PUT_LINE('Invalid product ID entered');
-- END;
-- Block 2:
-- DECLARE
-- TYPE type_basket IS RECORD
-- (basket bb_basket.idBasket%TYPE,
-- created bb_basket.dtcreated%TYPE,
-- qty bb_basket.quantity%TYPE,
-- sub bb_basket.subtotal%TYPE);
-- rec_basket type_basket;
-- lv_days_num NUMBER(3);
-- lv_shopper_num NUMBER(3) := 26;
-- BEGIN
-- SELECT idBasket, dtcreated, quantity, subtotal
-- INTO rec_basket
-- FROM bb_basket
-- WHERE idShopper = lv_shopper_num
-- AND orderplaced = 0;
-- lv_days_num := SYSDATE - rec_basket.created;
-- EXCEPTION
-- WHEN NO_DATA_FOUND THEN
-- DBMS_OUTPUT.PUT_LINE('You have no saved baskets!');
-- WHEN OTHERS THEN
-- DBMS_OUTPUT.PUT_LINE('A problem has occurred.');
-- DBMS_OUTPUT.PUT_LINE('Tech Support will be notified and
-- will contact you via e-mail.');
-- END;
Block 1:

This block uses a user-defined exception `ex_prod_update` to handle a specific condition when updating a product in the `bb_product` table. The `IF SQL%NOTFOUND` condition checks whether the `UPDATE` statement affected any rows. If no rows were affected, it raises the `ex_prod_update` exception. The `EXCEPTION` block then catches this specific exception and outputs a message indicating that an invalid product ID was entered. This is an example of using a user-defined exception for a specific situation.

Block 2:

This block involves a `SELECT` statement to retrieve basket information for a specific shopper (`lv_shopper_num`). It uses two different exception handlers:

1. `WHEN NO_DATA_FOUND`: This handler is executed if the `SELECT` statement does not find any data, indicating that the shopper has no saved baskets. In this case, it outputs a message saying, "You have no saved baskets!"

2. `WHEN OTHERS`: This handler is a catch-all for any other exceptions that might occur during the execution of the block. It outputs a generic error message indicating that a problem has occurred and suggests that tech support will be notified.

The `OTHERS` exception handler is a general exception handler that catches any exception not explicitly handled by the previous `WHEN` conditions. It is useful for logging or notifying unexpected errors. However, it's important to note that using `OTHERS` should be done carefully, as it may hide specific errors if not used judiciously. In this case, it provides a generic message for any unforeseen issues.

-- Case 4-2: Working with More Movie Rentals
-- Because business is growing and the movie stock is increasing at More Movie Rentals, the
-- manager wants to do more inventory evaluations. One item of interest is any movie with a total
-- stock value of $75 or more. The manager wants to focus on the revenue these movies are
-- generating to make sure the stock level is warranted. To make these stock queries more
-- efficient, the application team decides to add a column named STK_FLAG to the MM_MOVIE
-- table that stores an asterisk (*) if the stock value is $75 or more. Otherwise, the value should
-- be NULL. Add the column and create an anonymous block containing a CURSOR FOR loop to
-- perform this task. The company plans to run this program monthly to update the STK_FLAG
-- column before the inventory evaluation.
