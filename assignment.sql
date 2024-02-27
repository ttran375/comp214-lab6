-- Assignment 4-5: Handling Predefined Exceptions
-- A block of code has been created to retrieve basic customer information (see the
-- assignment04-05.sql file in the Chapter04 folder). The application page was modified so
-- that an employee can enter a customer number that could cause an error. An exception handler
-- needs to be added to the block that displays the message “Invalid shopper ID” onscreen. Use
-- an initialized variable named lv_shopper_num to provide a shopper ID. Test the block with the
-- shopper ID 99.
DECLARE
  rec_shopper    bb_shopper%ROWTYPE;
  lv_shopper_num bb_shopper.idShopper%TYPE := 99;
BEGIN
  BEGIN
    SELECT
      * INTO rec_shopper
    FROM
      bb_shopper
    WHERE
      idShopper = lv_shopper_num;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Invalid shopper ID');
  END;
END;

-- Assignment 4-6: Handling Exceptions with Undefined Errors
-- Brewbean’s wants to add a check constraint on the QUANTITY column of the
-- BB_BASKETITEM table. If a shopper enters a quantity value greater than 20 for an item,
-- Brewbean’s wants to display the message “Check Quantity” onscreen. Using a text editor, open
-- the assignment04-06.txt file in the Chapter04 folder. The first statement, ALTER TABLE,
-- must be executed to add the check constraint. The next item is a PL/SQL block containing an
-- INSERT action that tests this check constraint. Add code to this block to trap the check
-- constraint violation and display the message.
ALTER TABLE bb_basketitem ADD CONSTRAINT bitems_qty_ck CHECK (quantity < 20);

BEGIN
  BEGIN
    INSERT INTO bb_basketitem VALUES (
      88,
      8,
      10.8,
      21,
      16,
      2,
      3
    );
  EXCEPTION
    WHEN VALUE_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('Check Quantity');
  END;
END;

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
DECLARE
  lv_old_num NUMBER := 30;
  lv_new_num NUMBER := 4;
  v_count    NUMBER;
BEGIN
 -- Check if any items exist with the original basket ID
  SELECT
    COUNT(*) INTO v_count
  FROM
    bb_basketitem
  WHERE
    idBasket = lv_old_num;
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No items found with the original basket ID.');
  ELSE
 -- Update basket ID for items
    UPDATE bb_basketitem
    SET
      idBasket = lv_new_num
    WHERE
      idBasket = lv_old_num;
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid original basket ID');
END;

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
DECLARE
  lv_annual_raise_limit    CONSTANT NUMBER := 2000;
  lv_raise_percentage      CONSTANT NUMBER := 0.06;
  lv_total_salary_increase NUMBER := 0;
  CURSOR c_employee IS
  SELECT
    EMPNO,
    ENAME,
    SAL
  FROM
    EMPLOYEE
  WHERE
    JOB != 'PRESIDENT';
BEGIN
  FOR emp_rec IN c_employee LOOP
 -- Calculate raise amount
    DECLARE
      lv_raise_amount    NUMBER;
      lv_proposed_salary NUMBER;
    BEGIN
      lv_raise_amount := emp_rec.SAL * lv_raise_percentage;
 -- Cap raise amount if it exceeds the limit
      IF lv_raise_amount > lv_annual_raise_limit THEN
        lv_raise_amount := lv_annual_raise_limit;
      END IF;

      lv_proposed_salary := emp_rec.SAL + lv_raise_amount;
 -- Output current annual salary, raise, and proposed new annual salary
      DBMS_OUTPUT.PUT_LINE('Employee '
                           || emp_rec.EMPNO
                           || ': '
                           || 'Current Salary: $'
                           || emp_rec.SAL
                           || ', '
                           || 'Raise: $'
                           || lv_raise_amount
                           || ', '
                           || 'Proposed New Salary: $'
                           || lv_proposed_salary);
 -- Update employee salary
      UPDATE EMPLOYEE
      SET
        SAL = lv_proposed_salary
      WHERE
        EMPNO = emp_rec.EMPNO;
 -- Accumulate total salary increase
      lv_total_salary_increase := lv_total_salary_increase + lv_raise_amount;
    END;
  END LOOP;
 -- Output total cost of salary increases
  DBMS_OUTPUT.PUT_LINE('Total Cost of Salary Increases: $'
                       || lv_total_salary_increase);
END;
