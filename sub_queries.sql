-- String Aggegrate: STRING_AGG( expression. delimiter ORDER BY column_name (Optional))

CREATE TABLE company_individuals (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO company_individuals (first_name, last_name, department, salary) VALUES
('Alice', 'Johnson', 'IT', 60000),
('Bob', 'Smith', 'HR', 50000),
('Charlie', 'Brown', 'IT', 75000),
('David', 'Lee', 'Finance', 80000),
('Emma', 'Davis', 'Finance', 55000),
('Frank', 'Miller', 'HR', 62000),
('Grace', 'Wilson', 'IT', 72000),
('Hannah', 'Moore', 'Marketing', 47000),
('Isaac', 'Taylor', 'Finance', 65000),
('Jack', 'Anderson', 'Marketing', 52000);

-- Group by department and aggegrate employee names seperated by ,
SELECT department, STRING_AGG(first_name, ' , ' ORDER BY first_name ASC) FROM company_individuals GROUP BY department ORDER BY department DESC;

-- Sub Queries
-- Find Employees with Salary Greater than the Average Salary
SELECT first_name, last_name FROM company_individuals WHERE salary > (SELECT AVG(Salary) FROM company_individuals);

-- conditon ANY: Checks a if certain value satifies the condition using any values from (..., ..., ...)
-- conditon ALL: Checks a if certain value satifies the condition using all values from (..., ..., ...)

-- Find Employees in Departments with More than 2 Employees
SELECT first_name, last_name FROM company_individuals WHERE department IN (SELECT department FROM company_individuals GROUP BY department HAVING COUNT(department) >= 3);

-- Get Employees Who Earn More Than Any HR Employee

SELECT first_name, last_name FROM company_individuals WHERE salary > ANY(SELECT salary FROM company_individuals WHERE department = 'HR');

-- Find Departments Where the Maximum Salary is Above 70,000
SELECT DISTINCT department FROM company_individuals WHERE department IN (SELECT department FROM company_individuals GROUP BY department HAVING MAX(salary) > 70000);
-- Get the Second Highest Salary
SELECT MAX(salary) FROM company_individuals WHERE salary != (SELECT MAX(salary) FROM company_individuals);

-- Get Employees Whose Salary is in the Top 3
SELECT first_name, last_name FROM company_individuals WHERE salary IN (
    SELECT salary FROM company_individuals ORDER BY salary DESC LIMIT 3
);


-- Get Employees Working in the Same Department as ‘Alice’
SELECT first_name, last_name FROM company_individuals WHERE department = (SELECT department FROM company_individuals WHERE first_name = 'Alice');


-- SELECT ... FROM ... WHERE EXISTS ( Sub Query )
-- We want to execute the outer query when there is some result for the inner query. So the word exists is used

CREATE TABLE students(
    SID INT PRIMARY KEY,
    Sname VARCHAR(100),
    Faculty VARCHAR(100)
);

CREATE TABLE courses(
    CID INT PRIMARY KEY,
    CNAME VARCHAR(100),
    CreditHrs INT
);

CREATE TABLE enrollments(
    CID INT,
    SID INT,
    Semester VARCHAR(100),
    CONSTRAINT fk_courses FOREIGN KEY(CID) REFERENCES courses(CID),
    CONSTRAINT fk_student FOREIGN KEY(SID) REFERENCES students(SID)
);


INSERT INTO students (SID, SNAME, Faculty) VALUES
(1, 'John Doe', 'Computer Science'),
(2, 'Jane Smith', 'Mathematics'),
(3, 'Alice Brown', 'Physics'),
(4, 'Bob Johnson', 'Chemistry'),
(5,'Alice Smith','Electronics');
INSERT INTO courses (CID, CNAME, CreditHrs) VALUES
(101, 'Database Systems', 3),
(102, 'Calculus I', 4),
(103, 'Quantum Mechanics', 3),
(104, 'Organic Chemistry', 4);
INSERT INTO enrollments (CID, SID, Semester) VALUES
(101, 1, 'Fall'),
(102, 2, 'Spring'),
(101, 3, 'Fall'),
(101, 4, 'Spring'),
(103, 1, 'Spring');


-- Retrieve all students who are not enrolled in any course.
SELECT SID FROM students EXCEPT (SELECT DISTINCT SID FROM enrollments);
SELECT SID FROM students WHERE SID NOT IN (SELECT DISTINCT SID FROM enrollments);

-- Retrieve all courses that have no students enrolled
SELECT CID FROM courses EXCEPT (SELECT CID FROM enrollments);
SELECT CID FROM courses WHERE CID NOT IN (SELECT CID FROM enrollments);

-- List all students enrolled in Database System as well as Quantum Mechanics
SELECT sname FROM students, enrollments, courses WHERE enrollments.cid = courses.cid AND enrollments.sid = students.sid AND enrollments.CID = 101
INTERSECT
(SELECT sname FROM students, enrollments, courses WHERE enrollments.cid = courses.cid AND enrollments.sid = students.sid AND enrollments.CID = 103);

-- List all the students who are never enrolled in Calculus-I course
SELECT SID FROM students WHERE SID NOT IN (SELECT SID FROM enrollments WHERE CID = 102);
SELECT SID FROM students EXCEPT (SELECT SID FROM enrollments WHERE CID = 102);
