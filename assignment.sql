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
SET SERVEROUTPUT ON

DECLARE
 
  CURSOR basket_items_cur IS
    SELECT bi.idBasketItem, bi.idProduct, bi.Quantity, p.stock
    FROM bb_basketitem bi
    JOIN bb_product p ON bi.idProduct = p.idProduct
    WHERE bi.idBasket = :basket_number;
    
  basket_item_rec basket_items_cur%ROWTYPE;
  lv_flag_txt VARCHAR2(100) := 'All items in stock!';
  
BEGIN
 
  OPEN basket_items_cur;
  
 
  LOOP
    FETCH basket_items_cur INTO basket_item_rec;
    EXIT WHEN basket_items_cur%NOTFOUND;
    
   
    IF basket_item_rec.Quantity > basket_item_rec.stock THEN
      lv_flag_txt := 'All items NOT in stock!';
      EXIT;
    END IF;
  END LOOP;
  
 
  CLOSE basket_items_cur;
  
 
  DBMS_OUTPUT.PUT_LINE(lv_flag_txt);
  
END;
/

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

-- Assignment 4-3: Using Implicit Cursors
-- The BB_SHOPPER table in the Brewbean’s database contains a column named PROMO that
-- specifies promotions to send to shoppers. This column needs to be cleared after the promotion
-- has been sent. First, open the assignment04-03.txt file in the Chapter04 folder in a text
-- editor (such as Notepad). Run the UPDATE and COMMIT statements at the top of this file (not
-- the anonymous block at the end). Modify the anonymous block so that it displays the number of
-- rows updated onscreen. Run the block.
-- FIGURE 4-34 Querying the BB_SHOPPER table to check the PROMO column

-- Assignment 4-4: Using Exception Handling
-- In this assignment, you test a block containing a CASE statement for errors, and then add an
-- exception handler for a predefined exception:
-- 1. In Notepad, open the assignment04-04.sql file in the Chapter04 folder. Review the
-- block, which contains a CASE statement and no exception handlers.
-- 2. Copy and paste the block into SQL Developer, and run the block. Your results should
-- look like Figure 4-35. An error is raised because the state of NJ isn’t included in the CASE
-- statement; recall that a CASE statement must find a matching case.
-- 3. To correct this problem, add a predefined EXCEPTION handler that addresses this error
-- and displays “No tax” onscreen.
-- 4. Run the block again. Your results should look like Figure 4-36. Now the error is handled in
-- the block’s EXCEPTION section.
-- FIGURE 4-35 Raising an error with a CASE statement

-- Assignment 4-5: Handling Predefined Exceptions
-- A block of code has been created to retrieve basic customer information (see the
-- assignment04-05.sql file in the Chapter04 folder). The application page was modified so
-- that an employee can enter a customer number that could cause an error. An exception handler
-- needs to be added to the block that displays the message “Invalid shopper ID” onscreen. Use
-- an initialized variable named lv_shopper_num to provide a shopper ID. Test the block with the
-- shopper ID 99.

-- Assignment 4-6: Handling Exceptions with Undefined Errors
-- Brewbean’s wants to add a check constraint on the QUANTITY column of the
-- BB_BASKETITEM table. If a shopper enters a quantity value greater than 20 for an item,
-- Brewbean’s wants to display the message “Check Quantity” onscreen. Using a text editor, open
-- the assignment04-06.txt file in the Chapter04 folder. The first statement, ALTER TABLE,
-- must be executed to add the check constraint. The next item is a PL/SQL block containing an
-- INSERT action that tests this check constraint. Add code to this block to trap the check
-- constraint violation and display the message.

-- Assignment 4-7: Handling Exceptions with User-Defined Errors
-- Sometimes Brewbean’s customers mistakenly leave an item out of a basket that’s already been
-- checked out, so they create a new basket containing the missing items. However, they request
-- FIGURE 4-36 Using the CASE_NOT_FOUND exception handler
-- that the baskets be combined so that they aren’t charged extra shipping. An application page
-- has been developed that enables employees to change the basket ID of items in the
-- BB_BASKETITEM table to another existing basket’s ID to combine the baskets. A block has
-- been constructed to support this page (see the assignment04−07.sql file in the Chapter04
-- folder). However, an exception handler needs to be added to trap the situation of an invalid
-- basket ID being entered for the original basket. In this case, the UPDATE affects no rows but
-- doesn’t raise an Oracle error. The handler should display the message “Invalid original basket
-- ID” onscreen. Use an initialized variable named lv_old_num with a value of 30 and another
-- named lv_new_num with a value of 4 to provide values to the block. First, verify that no item
-- rows with the basket ID 30 exist in the BB_BASKETITEM table.

-- Assignment 4-8: Processing and Updating a Group of Rows
-- To help track employee information, a new EMPLOYEE table was added to the Brewbean’s
-- database. Review the data in this table. A PL/SQL block is needed to calculate annual raises
-- and update employee salary amounts in the table. Create a block that addresses all the
-- requirements in the following list. All salaries in the EMPLOYEE table are recorded as
-- monthly amounts. Tip: Display the calculated salaries for verification before including the
-- update action.
-- • Calculate 6% annual raises for all employees except the president.
-- • If a 6% raise totals more than $2,000, cap the raise at $2,000.
-- • Update the salary for each employee in the table.
-- • For each employee number, display the current annual salary, raise, and proposed
-- new annual salary.
-- • Finally, following the details for each employee, show the total cost of all
-- employees’ salary increases for Brewbean’s.
