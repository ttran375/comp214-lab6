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
  -- Declare constants for annual raise limit and raise percentage
  lv_annual_raise_limit    CONSTANT NUMBER := 2000;
  lv_raise_percentage      CONSTANT NUMBER := 0.06;
  -- Variable to store total salary increase
  lv_total_salary_increase NUMBER := 0;
  -- Cursor to select employee data
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
  -- Loop through each employee record fetched by the cursor
  FOR emp_rec IN c_employee LOOP
    -- Declare variables for raise amount and proposed salary
    DECLARE
      lv_raise_amount    NUMBER;
      lv_proposed_salary NUMBER;
    BEGIN
      -- Calculate raise amount based on raise percentage
      lv_raise_amount := emp_rec.SAL * lv_raise_percentage;
      -- Check if raise amount exceeds the annual raise limit
      IF lv_raise_amount > lv_annual_raise_limit THEN
        lv_raise_amount := lv_annual_raise_limit;
      END IF;

      -- Calculate proposed new salary after raise
      lv_proposed_salary := emp_rec.SAL + lv_raise_amount;
      
      -- Output information about employee's current salary, raise, and proposed new salary
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

      -- Update employee's salary in the EMPLOYEE table
      UPDATE EMPLOYEE
      SET
        SAL = lv_proposed_salary
      WHERE
        EMPNO = emp_rec.EMPNO;

      -- Add raise amount to total salary increase
      lv_total_salary_increase := lv_total_salary_increase + lv_raise_amount;
    END;
  END LOOP;
  -- Output total cost of salary increases
  DBMS_OUTPUT.PUT_LINE('Total Cost of Salary Increases: $'
                       || lv_total_salary_increase);
END;
