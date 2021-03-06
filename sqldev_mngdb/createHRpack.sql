DROP PROCEDURE raise_amount;
DROP FUNCTION get_sal;

CREATE OR REPLACE PACKAGE hr_pack 
IS
 PROCEDURE raise_amount
   (p_id IN employees.employee_id%TYPE,
    p_raise_amt IN NUMBER default 0);
 FUNCTION get_sal
  (p_id IN employees.employee_id%TYPE,
   p_increment IN NUMBER := 1)
   RETURN NUMBER;
END hr_pack;
/

CREATE OR REPLACE PACKAGE BODY hr_pack
IS
  PROCEDURE raise_amount
   (p_id IN employees.employee_id%TYPE,
    p_raise_amt IN NUMBER default 0)
  IS
  BEGIN
    UPDATE employees
      SET salary = salary * (1+p_raise_amt)
      WHERE employee_id = p_id;
  END raise_amount;

  FUNCTION get_sal
  (p_id IN employees.employee_id%TYPE,
   p_increment IN NUMBER := 1 )
  RETURN NUMBER
  IS
    v_sal employees.salary%TYPE := 0;
    e_toomuch EXCEPTION;
  BEGIN
    IF p_increment < 1 or p_increment > 1.5 THEN
      RAISE e_toomuch;
    END IF; 
    SELECT salary * p_increment
      INTO v_sal
      FROM employees
      WHERE employee_id = p_id;
    RETURN v_sal;
  EXCEPTION
    WHEN e_toomuch THEN
      dbms_output.put_line ('Invalid increment amount');
      return null;
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line ('Invalid employee Id');
      return null;
    WHEN OTHERS THEN
      dbms_output.put_line ('Error occurred in processing');
      return null;
  END get_sal;
END hr_pack;
/