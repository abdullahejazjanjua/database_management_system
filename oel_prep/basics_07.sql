CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary NUMERIC(10,2),
    department VARCHAR(50)
);

INSERT INTO employees (emp_id, name, salary, department) VALUES
(1, 'Alice', 48000, 'HR'),
(2, 'Bob', 52000, 'Engineering'),
(3, 'Charlie', 47000, 'Engineering'),
(4, 'David', 60000, 'Marketing'),
(5, 'Eve', 45000, 'Finance'),
(6, 'Frank', 39000, 'HR'),
(7, 'Grace', 51000, 'Finance');

DO $$
DECLARE
	emp_cur cursor FOR SELECT name, salary FROM employees;
	emp_name employees.name%type;
	emp_salary employees.salary%type;
BEGIN

	OPEN emp_cur;
	
		LOOP
			FETCH emp_cur INTO emp_name, emp_salary;
			IF NOT FOUND THEN
				EXIT;
			END IF;


			RAISE NOTICE 'Name: %, Salary: %', emp_name, emp_salary;
			
		END LOOP;

		
	CLOSE emp_cur;

END; $$


DO $$
DECLARE
	emp_cur CURSOR FOR SELECT name, salary, department FROM employees AS E1 WHERE salary > (
		SELECT AVG(Salary) FROM employees AS E2 
		WHERE E2.department = E1.department
		GROUP BY E2.department
	);
	emp_name employees.name%type;
	emp_salary employees.salary%type;
	emp_dep employees.department%type;
BEGIN

	OPEN emp_cur;
	LOOP	
		FETCH emp_cur INTO emp_name, emp_salary, emp_dep;
		IF NOT FOUND THEN
			EXIT;
		END IF;

		RAISE NOTICE 'Name: %, Salary: %, Department: %', emp_name, emp_salary, emp_dep;
	END LOOP;
	CLOSE emp_cur;

END; $$


CREATE OR REPLACE FUNCTION get_emp_count()
RETURNS INT
LANGUAGE PLPGSQL
AS $$
DECLARE
	emp_count INT := 0;
BEGIN
	SELECT COUNT(*) INTO emp_count FROM employees;
	RETURN emp_count;
END; $$

SELECT get_emp_count();


CREATE OR REPLACE FUNCTION get_avg(dep employees.department%type)
RETURNS employees.salary%type
LANGUAGE PLPGSQL
AS $$
DECLARE
	avg_sal employees.salary%type;
BEGIN
	SELECT AVG(salary) INTO avg_sal FROM employees WHERE department = dep;
	RETURN avg_sal;
END $$;

SELECT get_avg('Engineering');

CREATE OR REPLACE FUNCTION emp_sal()
RETURNS VOID
LANGUAGE PLPGSQL
AS $$
DECLARE
	avg_sal employees.salary%type;
	emp_cur CURSOR FOR SELECT name FROM employees WHERE salary > avg_sal; 
	emp_name employees.name%type;
BEGIN
	SELECT AVG(salary) INTO avg_sal FROM employees;
	OPEN emp_cur;
	
	LOOP
	
		FETCH emp_cur INTO emp_name;
		
		IF NOT FOUND THEN
			EXIT;
		END IF;
		
		RAISE NOTICE 'Name: %', emp_name;
		
	END LOOP;
	
	CLOSE emp_cur;
	
END $$;


SELECT emp_sal();


CREATE OR REPLACE PROCEDURE inc_sal(id employees.emp_id%type)
LANGUAGE PLPGSQL
AS $$
DECLARE
BEGIN
	UPDATE employees SET salary = salary * 1.1 WHERE emp_id = id;

END; $$

CALL inc_sal(1);

CREATE OR REPLACE PROCEDURE inc_sal_dep(dep employees.department%type, perc NUMERIC(2,1))
LANGUAGE PLPGSQL
AS $$
DECLARE
	emp_cur CURSOR FOR SELECT name, emp_id, salary FROM employees WHERE department = dep;
	id employees.emp_id%type;
	old_sal employees.salary%type;
	emp_name employees.name%type;
BEGIN
	OPEN emp_cur;
	LOOP
		FETCH emp_cur INTO emp_name, id, old_sal;
		IF NOT FOUND THEN
			EXIT;
		END IF;
		
		RAISE NOTICE 'NAME: %, Before: %, After: %', emp_name, old_sal, old_sal * perc;
		UPDATE employees SET salary = salary * perc WHERE emp_id = id;

	END LOOP;

	CLOSE emp_cur;

END; $$

CALL inc_sal_dep('HR', 1.1);

CREATE OR REPLACE PROCEDURE do_sm()
LANGUAGE PLPGSQL
AS $$
DECLARE
	dep employees.department%type;
	emp_cur CURSOR FOR SELECT emp_id, name, salary FROM employees WHERE department = dep;
	old_sal employees.salary%type;
	emp_name employees.name%type;
	id employees.emp_id%type;
BEGIN
	SELECT department INTO dep FROM employees GROUP BY department ORDER BY SUM(SALARY) DESC LIMIT 1;
	OPEN emp_cur;
	LOOP
		FETCH emp_cur INTO id, emp_name, old_sal;
		IF NOT FOUND THEN
			EXIT;
		END IF;
		UPDATE employees SET salary = salary * 1.15 WHERE emp_id = id;
		RAISE NOTICE 'Name: %, Before: %, After: %', emp_name, old_sal, old_sal * 1.15;

	END LOOP;

	CLOSE emp_cur;

END; $$

CALL do_sm();




