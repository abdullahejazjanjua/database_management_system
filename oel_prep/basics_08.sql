CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary NUMERIC(10, 2),
    department VARCHAR(50),
    last_updated TIMESTAMP DEFAULT '2025-05-07 01:29:53.997673'
);

DROP TABLE employees
INSERT INTO employees (emp_id, name, salary, department) VALUES
(1, 'Alice', 48000, 'HR'),
(2, 'Bob', 52000, 'Engineering'),
(3, 'Charlie', 47000, 'Engineering'),
(4, 'David', 60000, 'Marketing'),
(5, 'Eve', 45000, 'Finance'),
(6, 'Frank', 39000, 'HR'),
(7, 'Grace', 51000, 'Finance');

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Marketing'),
(4, 'Finance');


CREATE OR REPLACE FUNCTION log_sal()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
	
BEGIN
	IF NEW.salary != OLD.salary THEN
		UPDATE employees SET last_updated = CURRENT_TIMESTAMP WHERE emp_id = OLD.emp_id;
	END IF;
	
	RETURN NEW;
END; $$

CREATE OR REPLACE TRIGGER log_sal_trig
AFTER UPDATE
ON employees
FOR EACH ROW
	EXECUTE FUNCTION log_sal();


UPDATE employees SET salary = 1 WHERE emp_id = 1;

SELECT * FROM employees;


CREATE OR REPLACE FUNCTION check_sal()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
BEGIN
	IF NEW.salary < 30000 THEN
		RAISE EXCEPTION 'Invalid Salary';
		
	END IF;
	RETURN NEW;

END; $$

CREATE OR REPLACE TRIGGER check_sal_trig
BEFORE INSERT
ON employees
FOR EACH ROW
	EXECUTE FUNCTION check_sal()

INSERT INTO employees (emp_id, name, salary, department) VALUES
(10, 'John', 2, 'HR');


CREATE TABLE sal_changes(
	emp_id INT,
	new_salary NUMERIC(10, 2),
	old_salary NUMERIC(10, 2),
	updated TIMESTAMP
);


CREATE OR REPLACE FUNCTION sal_chag()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
BEGIN
	IF NEW.salary != OLD.salary THEN
		INSERT INTO sal_changes(emp_id, new_salary, old_salary, updated) VALUES
		(OLD.emp_id, NEW.salary, OLD.salary, CURRENT_TIMESTAMP);
	END IF;
	RETURN NEW;
END; $$


CREATE OR REPLACE TRIGGER sal_chag_trig
AFTER UPDATE
ON employees
FOR EACH ROW
	EXECUTE FUNCTION sal_chag();

UPDATE employees SET salary = 50000 WHERE emp_id = 1;

SELECT * FROM sal_changes;

DELETE FROM sal_changes;


CREATE VIEW emp_info AS SELECT * FROM employees;
SELECT * FROM emp_info;


CREATE VIEW salary_dep AS SELECT department, AVG(salary) FROM employees GROUP BY department;
SELECT * FROM salary_dep;


CREATE OR REPLACE VIEW sal_abv_dep AS SELECT E1.name, E1.department FROM employees AS E1 WHERE E1.salary > (
	SELECT AVG(salary) FROM employees AS E2 
	WHERE E1.department = E2.department
	GROUP BY E2.department
);

SELECT * FROM sal_abv_dep;

CREATE INDEX sal_index ON employees(salary);

EXPLAIN ANALYZE SELECT salary FROM employees;

