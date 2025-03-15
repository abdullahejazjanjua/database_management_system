-- Department Table
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    min_salary DECIMAL(10,2)
);
--Employee Table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id INT, --Foreign key referencing department
    salary DECIMAL(10,2),
    Foreign key(department_id) references Department(department_id)
);
-- Project Table
CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT, -- Foreign key referencing Employee
    CONSTRAINT fk_employee Foreign key(emp_id) references Employee(emp_id)
);
INSERT INTO Department (department_id, department_name, min_salary) VALUES
(1, 'HR', 40000),
(2, 'IT', 50000),
(3, 'Finance', 70000),
(4, 'Marketing', 45000);-- Insert Sample Data
INSERT INTO Employee (emp_id, emp_name, department_id, salary) VALUES
(1, 'Alice', 1, 60000),
(2, 'Bob', 2, 75000),
(3, 'Charlie', 1, 50000),
(4, 'David', NULL, 55000),
(5, 'Eve', 3, 80000);
INSERT INTO Project (project_id, project_name, emp_id) VALUES
(1, 'Project A', 1),
(2, 'Project B', 2),
(3, 'Project C', 3),
(4, 'Project D', 5),
(5, 'Project E', NULL);

SELECT * FROM Department; 
SELECT * FROM Project;
SELECT * FROM employee;


-- Inner Join
SELECT emp_id, emp_name, department_name, salary 
FROM employee 
JOIN department 
ON employee.department_id = department.department_id;

-- Left JOIN
SELECT emp_id, emp_name, department_name, salary 
FROM employee 
LEFT JOIN department 
ON employee.department_id = department.department_id;

-- RIGHT JOIN
SELECT emp_id, emp_name, department_name, salary 
FROM employee 
RIGHT JOIN department 
ON employee.department_id = department.department_id;

-- FULL JOIN
SELECT emp_id, emp_name, department_name, salary 
FROM employee 
FULL JOIN department 
ON employee.department_id = department.department_id;

-- Equi-Join
SELECT emp_id, emp_name, department_name, salary 
FROM employee, department 
WHERE employee.department_id = department.department_id;

-- Natural Join
SELECT emp_id, emp_name, department_name, salary 
FROM employee 
NATURAL JOIN department;

-- Self Join
SELECT E1.emp_name, E1.salary
FROM Employee AS E1, Employee AS E2 
WHERE E1.salary > E2.salary;

-- Add practice
SELECT patients.patient_id, first_name, last_name FROM patients 
JOIN admissions ON 
patients.patient_id = admissions.patient_id WHERE diagnosis = 'Dementia';

SELECT 
  CONCAT(patients.first_name, ' ', patients.last_name) AS patient_name, 
  diagnosis,
  CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name
FROM patients
JOIN admissions ON patients.patient_id = admissions.patient_id 
JOIN doctors ON doctors.doctor_id = admissions.attending_doctor_id;

SELECT 
	patients.patient_id, 
    patients.first_name, 
    patients.last_name,
    doctors.specialty
FROM patients
JOIN admissions ON patients.patient_id = admissions.patient_id
JOIN doctors ON doctors.doctor_id = admissions.attending_doctor_id 
WHERE doctors.first_name = 'Lisa' AND diagnosis = 'Epilepsy';

select 
	DISTINCT patients.patient_id, 
    concat(patients.patient_id, LENGTH(patients.last_name), YEAR(birth_date)) AS temp_password
FROM patients 
JOIN admissions ON patients.patient_id = admissions.patient_id;

SELECT 
	MAX(weight) - MIN(weight) as weight_difference 
FROM patients 
WHERE last_name = 'Maroni';