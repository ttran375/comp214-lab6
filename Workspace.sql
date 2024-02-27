DECLARE
  v_state CHAR(2) := 'NJ';
  v_tax_rate NUMBER;
BEGIN
  v_tax_rate := 
    CASE v_state
      WHEN 'CA' THEN 0.0825
      WHEN 'NY' THEN 0.08875
      WHEN 'IL' THEN 0.0875
      ELSE NULL -- Handle unexpected states
    END;
    
  IF v_tax_rate IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('No tax');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Tax rate for ' || v_state || ' is ' || v_tax_rate);
  END IF;
END;
/
