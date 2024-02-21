-- Hands-On Assignments Part II

-- Assignment 4-9: Using an Explicit Cursor
-- Create a block to retrieve and display pledge and payment information for a specific donor. For
-- each pledge payment from the donor, display the pledge ID, pledge amount, number of monthly
-- payments, payment date, and payment amount. The list should be sorted by pledge ID and then
-- by payment date. For the first payment made for each pledge, display “first payment” on that
-- output row.

-- Assignment 4-10: Using a Different Form of Explicit Cursors
-- Redo Assignment 4-9, but use a different cursor form to perform the same task.

-- Assignment 4-11: Adding Cursor Flexibility
-- An administration page in the DoGood Donor application allows employees to enter multiple
-- combinations of donor type and pledge amount to determine data to retrieve. Create a block
-- with a single cursor that allows retrieving data and handling multiple combinations of donor type
-- and pledge amount as input. The donor name and pledge amount should be retrieved and
-- displayed for each pledge that matches the donor type and is greater than the pledge amount
-- indicated. Use a collection to provide the input data. Test the block using the following input
-- data. Keep in mind that these inputs should be processed with one execution of the block. The
-- donor type code I represents Individual, and B represents Business.
-- Donor Type < Pledge Amount
-- I 250
-- B 500

-- Assignment 4-12: Using a Cursor Variable
-- Create a block with a single cursor that can perform a different query of pledge payment data
-- based on user input. Input provided to the block includes a donor ID and an indicator value of
-- D or S. The D represents details and indicates that each payment on all pledges the donor has
-- made should be displayed. The S indicates displaying summary data of the pledge payment
-- total for each pledge the donor has made.
-- Assignment 4-13: Exception Handling
-- The DoGood Donor application contains a page that allows administrators to change the ID
-- assigned to a donor in the DD_DONOR table. Create a PL/SQL block to handle this task.
-- Include exception-handling code to address an error raised by attempting to enter a duplicate
-- donor ID. If this error occurs, display the message “This ID is already assigned.” Test the code
-- by changing donor ID 305. (Don’t include a COMMIT statement; roll back any DML actions used.)
