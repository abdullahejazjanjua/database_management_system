-- GROUP BY: Aggregate all rows by a specific column
-- HAVING: WHERE for GROUP BY. WHERE CAN'T BE USED WITH GROUP BY
-- Like ... GROUP BY column_nmae WHERE .. --> This will give error
-- So we used HAVING
-- NOTE: WHERE can be used before the addition of GROUP BY
-- Like .. WHERE .. GROUP BY .. --> This works 

CREATE TABLE employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO employees (EmployeeID, FirstName, LastName, Department, Salary) VALUES
(1, 'Alice', 'Johnson', 'HR', 60000),
(2, 'Bob', 'Smith', 'IT', 80000),
(4, 'David', 'Wilson', 'IT', 90000),
(5, 'Emma', 'Davis', 'Finance', 75000),
(6, 'Frank', 'Miller', 'HR', 62000),
(7, 'Grace', 'Taylor', 'IT', 58000),
(8, 'Henry', 'Anderson', 'IT', 95000),
(9, 'Isabella', 'Thomas', 'Finance', 72000),
(10, 'Jack', 'White', 'IT', 53000);


SELECT * FROM employees;

-- Count employees in each department
SELECT Department FROM employees GROUP BY Department; -- Group by department
SELECT Department, COUNT(Department) FROM employees GROUP BY Department; -- Count the instances of each department

-- Adding a column and values
ALTER TABLE employees ADD COLUMN JoiningDate DATE;
UPDATE employees SET JoiningDate = '2023-01-15' WHERE Department = 'HR';
UPDATE employees SET JoiningDate = '2023-02-10' WHERE Department = 'IT';
UPDATE employees SET JoiningDate = '2023-03-05' WHERE Department = 'Finance';

-- Grouping by Department and JoiningDate
SELECT Department, COUNT(Department) AS department_count, JoiningDate, COUNT(JoiningDate) AS JoiningDate_Count FROM employees GROUP BY Department, JoiningDate;

-- Group by date and count total salary
SELECT JoiningDate, SUM(Salary) FROM employees GROUP BY JoiningDate; -- Groups by Departments and Sums salary for that department

-- Use HAVING
SELECT Department, SUM(Salary) AS total_salary FROM employees GROUP BY Department HAVING SUM(Salary) > 122000; -- HAVING Adds a condition like WHERE but for GROUP BY
SELECT Department, SUM(Salary) AS total_salary FROM employees GROUP BY Department WHERE SUM(Salary) > 122000; -- This will give error

SELECT Department, SUM(Salary) AS total_salary FROM employees WHERE Department != 'IT' GROUP BY Department; -- This works as WHERE is before GROUP BY


-- ORDER BY

SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY Department ASC, Salary DESC; -- Sorting by mutiple rows

-- ALL USE CASES

SELECT Department, AVG(Salary) AS average_salary FROM employees GROUP BY Department HAVING AVG(Salary) <75000 ORDER BY AVG(Salary) DESC;
