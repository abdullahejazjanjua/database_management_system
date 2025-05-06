CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


CREATE TABLE grades (
    student_id INT,
    grade INT,
    grade_date DATE
);

-- Insert sample data
INSERT INTO grades (student_id, grade, grade_date) VALUES
(1, 85, '2025-01-01'),
(1, 90, '2025-02-01'),
(1, 88, '2025-03-01'),
(2, 78, '2025-01-01'),
(2, 82, '2025-02-01'),
(2, 80, '2025-03-01');


-- Insert sample data
INSERT INTO students (student_id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO courses (course_id, course_name) VALUES
(104, 'Religious Studies')
(101, 'Math'),
(102, 'Science'),
(103, 'History');

INSERT INTO enrollments (student_id, course_id) VALUES
(1, 101),
(1, 102),
(1, 103),
(2, 101),
(2, 102),
(3, 101),
(3, 102),
(3, 103);


-- Find Students Enrolled in All Courses


SELECT name FROM students WHERE student_id IN (
	
	SELECT enrollments.student_id FROM enrollments 
	JOIN students ON students.student_id = enrollments.student_id
	JOIN courses ON courses.course_id = enrollments.course_id
	GROUP BY enrollments.student_id
	HAVING COUNT(*) = (SELECT COUNT(*) FROM courses)
);

-- Calculate Running Total of Grades
SELECT grades.student_id, name, SUM(grade) FROM grades 
JOIN students ON students.student_id = grades.student_id
GROUP BY grades.student_id, name;


-- Identify Students with Grades Above Class Average

SELECT DISTINCT name FROM grades 
JOIN students ON students.student_id = grades.student_id WHERE grades.grade > (
	SELECT AVG(grade) FROM grades
)

-- List Courses with No Enrollments

SELECT course_name FROM courses 
WHERE course_id IN (
	SELECT course_id FROM courses
	EXCEPT
	SELECT course_id FROM enrollments
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    manager_id INT
);

-- Insert sample data
INSERT INTO employees (emp_id, name, salary, manager_id) VALUES
(1, 'John', 5000, NULL),
(2, 'Jane', 6000, 1),
(3, 'Doe', 7000, 1),
(4, 'Smith', 8000, 2)
(5, 'Akbar', 3000, 2)
;

--  Find Employees Earning More Than Their Managers
SELECT E2.name, E2.salary, E1.name, E1.salary FROM employees AS E1 
JOIN employees AS E2 ON E1.emp_id = E2.manager_id
WHERE E2.salary > E1.salary;

-- Find the Second Highest Salary

SELECT MAX(SALARY) FROM (
	SELECT * FROM employees WHERE salary != (SELECT MAX(salary) FROM employees)
);






