CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT,
    department_id INT
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

DROP TABLE employees;
DROP TABLE departments;

INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'Support');


INSERT INTO employees (emp_id, name, manager_id, department_id) VALUES
(101, 'Alice', NULL, 1),
(102, 'Bob', 101, 2),
(103, 'Charlie', 101, 2),
(104, 'David', 102, NULL),
(105, 'Eve', 102, 3),
(106, 'Frank', 105, 4),
(107, 'Grace', NULL, NULL),
(108, 'Heidi', 103, 5),
(109, 'Ivan', 102, 6); -- department_id = 6 (no matching department)


SELECT DISTINCT employees.name FROM employees, departments 
WHERE employees.department_id > departments.department_id;

SELECT employees.name, departments.department_name 
FROM employees 
JOIN departments ON departments.department_id = employees.department_id;

SELECT E1.name, E2.name 
FROM employees AS E1
JOIN employees AS E2 ON E1.manager_id = E2.emp_id;

SELECT employees.name, departments.department_name
FROM employees
FULL OUTER JOIN departments ON departments.department_id = employees.department_id;

SELECT employees.name, departments.department_name
FROM employees
LEFT OUTER JOIN departments ON departments.department_id = employees.department_id;

SELECT employees.name, departments.department_name
FROM employees
RIGHT OUTER JOIN departments ON departments.department_id = employees.department_id;

SELECT employees.name, departments.department_name 
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT employees.name, departments.department_name 
FROM departments, employees;


SELECT DISTINCT E1.name FROM employees AS E1
JOIN employees AS E2 ON E1.department_id = E2.department_id
AND E1.emp_id != E2.emp_id;





