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


CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    score INT
);

INSERT INTO students (student_id, name, score) VALUES
(101, 'Nina', 92),
(102, 'Omar', 76),
(103, 'Priya', 63),
(104, 'Ravi', 49),
(105, 'Sara', 85),
(106, 'Tom', 38);


DO $$

DECLARE
	a INT := 1;
	b INT := 2;
	c INT := 0;
	
BEGIN
	
	C := a + b;
	RAISE NOTICE 'SUM: %', C;

END $$


DO $$
DECLARE
	emp_rec RECORD;
BEGIN

	FOR emp_rec IN SELECT name, salary FROM employees LOOP
		RAISE NOTICE '% earns %', emp_rec.name, emp_rec.salary;
	END LOOP;

END; $$


DO $$
DECLARE
	avg_salary employees.salary%type;
	emp_rec RECORD;
BEGIN

	SELECT AVG(salary) INTO avg_salary FROM employees;
	FOR emp_rec IN SELECT name, salary FROM employees WHERE salary > avg_salary LOOP
		RAISE NOTICE '% earns %', emp_rec.name, emp_rec.salary;
	END LOOP;

END; $$


DO $$
DECLARE
	count INT := 5;
BEGIN
	WHILE count >= 0 LOOP
	
		RAISE NOTICE '%', count;
	
		count := count - 1;
	END LOOP;
END; $$

DO $$
DECLARE
	emp_rec RECORD;
BEGIN
	
	FOR emp_rec IN SELECT * FROM employees WHERE salary < 50000 LOOP
		RAISE NOTICE 'Name: % --> Before: %, After: %', emp_rec.name, emp_rec.salary, emp_rec.salary * 1.1;


		UPDATE employees SET salary = salary * 1.1 WHERE emp_id = emp_rec.emp_id;
		
	END LOOP;
END; $$


DO $$
DECLARE 
	sscore students.score%type;
	remark TEXT;
BEGIN
	SELECT score INTO sscore FROM students WHERE student_id = 102;

	CASE 
		WHEN sscore < 50 THEN
			remark := 'Fail';
		WHEN sscore >= 50 AND sscore <= 74 THEN
			remark := 'Pass';
		WHEN sscore >= 75 AND sscore <= 89 THEN
			remark := 'Merit';
		WHEN sscore >= 90 THEN
			remark := 'Distinction';
		ELSE
			remark := 'Invalid';
			
	END CASE;

	RAISE NOTICE 'Remark: %', remark;

END; $$

ALTER TABLE students ADD COLUMN grade CHAR(1);

ALTER TABLE students RENAME COLUMN grade TO Marks;

DO $$
DECLARE
	std_rec RECORD;
	grade char(1);
BEGIN
	
	
	FOR std_rec IN SELECT * FROM students LOOP
		CASE 
			WHEN std_rec.score < 50 THEN
				grade = 'F';
			WHEN std_rec.score >= 50 AND std_rec.score <= 74 THEN
				grade = 'C';
			WHEN std_rec.score >= 75 AND std_rec.score <= 89 THEN
				grade = 'B';
			WHEN std_rec.score >= 90 THEN
				grade = 'A';
			ELSE
				grade = 'W';	
	END CASE;

	UPDATE students SET Marks = grade WHERE student_id = std_rec.student_id;
		
	END LOOP;	
END; $$














