# Case Projects

## Case 4-1: Using Exception Handlers in the Brewbean’s Application

A new part-time programming employee has been reviewing some PL/SQL code you
developed. The following two blocks contain a variety of exception handlers. Explain the
different types for the new employee.

Block 1:

This block uses a user-defined exception `ex_prod_update` to handle a specific condition when updating a product in the `bb_product` table. The `IF SQL%NOTFOUND` condition checks whether the `UPDATE` statement affected any rows. If no rows were affected, it raises the `ex_prod_update` exception. The `EXCEPTION` block then catches this specific exception and outputs a message indicating that an invalid product ID was entered. This is an example of using a user-defined exception for a specific situation.

Block 2:

This block involves a `SELECT` statement to retrieve basket information for a specific shopper (`lv_shopper_num`). It uses two different exception handlers:

1. `WHEN NO_DATA_FOUND`: This handler is executed if the `SELECT` statement does not find any data, indicating that the shopper has no saved baskets. In this case, it outputs a message saying, "You have no saved baskets!"

2. `WHEN OTHERS`: This handler is a catch-all for any other exceptions that might occur during the execution of the block. It outputs a generic error message indicating that a problem has occurred and suggests that tech support will be notified.

The `OTHERS` exception handler is a general exception handler that catches any exception not explicitly handled by the previous `WHEN` conditions. It is useful for logging or notifying unexpected errors. However, it's important to note that using `OTHERS` should be done carefully, as it may hide specific errors if not used judiciously. In this case, it provides a generic message for any unforeseen issues.
