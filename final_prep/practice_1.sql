SELECT first_name, last_name 
FROM Employees 
JOIN departments ON departments.dept_id = employees.dept_id
WHERE salary > 75000 and departments.dept_name = 'IT';

SELECT departments.dept_name, COUNT(*) AS total_employees 
FROM Employees 
JOIN departments ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_id
HAVING COUNT(*) > 1 
ORDER BY COUNT(*) DESC;

ALTER TABLE employees ALTER COLUMN salary SET NOT NULL;


SELECT departments.dept_name, MAX(salary) 
FROM Employees 
JOIN departments ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_id;


SELECT Employees.first_name, Employees.last_name, Employee_Project_Assignment.project_id
FROM Employees 
LEFT JOIN Employee_Project_Assignment ON Employee_Project_Assignment.emp_id = employees.emp_id;


CREATE OR REPLACE FUNCTION get_dept_emp(department_name departments.dept_name%type)
RETURNS TABLE(first_name employees.first_name%type, last_name employees.last_name%type)
LANGUAGE PLPGSQL
AS $$
DECLARE
BEGIN

	RETURN QUERY SELECT employees.first_name, employees.last_name FROM employees 
	JOIN departments ON departments.dept_id = employees.dept_id
	WHERE departments.dept_name = department_name;


END; $$

SELECT * FROM get_dept_emp('IT');

DO $$
DECLARE
	emp_cur CURSOR FOR SELECT employees.first_name, employees.last_name, projects.project_name
						FROM Employee_Project_Assignment 
						JOIN employees ON employees.emp_id = Employee_Project_Assignment.emp_id
						JOIN projects ON projects.project_id = Employee_Project_Assignment.project_id;
	emp_name_1 employees.first_name%type;
	emp_name_2 employees.last_name%type;
	proj_name projects.project_name%type;
						
BEGIN
	OPEN emp_cur;
		LOOP 
			FETCH emp_cur INTO emp_name_1, emp_name_2, proj_name;
			IF NOT FOUND THEN
				EXIT;
			END IF;

			RAISE NOTICE 'Name: % %, Project: %', emp_name_1, emp_name_2, proj_name;
		END LOOP;
	
	CLOSE emp_cur;
END; $$	


CREATE OR REPLACE FUNCTION update_sal()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
	
BEGIN
	IF NEW.role != OLD.role THEN
		UPDATE employees SET salary = salary + (salary * 0.05) WHERE emp_id = OLD.emp_id;
	END IF;

	RETURN NEW;
END; $$

CREATE OR REPLACE TRIGGER update_dal_trig
AFTER UPDATE 
ON Employee_Project_Assignment
FOR EACH ROW 
	EXECUTE FUNCTION update_sal();

UPDATE Employee_Project_Assignment SET role = 'Janitor' WHERE emp_id = 2;

SELECT * FROM employees;




DROP TABLE employees, Employee_Project_Assignment, projects, salaries CASCADE;
DROP TABLE departments;





