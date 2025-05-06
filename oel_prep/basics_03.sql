CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    course_id INT,
    semester VARCHAR(20),
    grade CHAR(1)
);

DROP TABLE enrollments;

INSERT INTO enrollments (enrollment_id, student_name, course_id, semester, grade) VALUES
(1, 'Alice', 101, 'Fall 2024', 'A'),
(2, 'Bob', 101, 'Fall 2024', 'B'),
(3, 'Charlie', 102, 'Fall 2024', 'A'),
(4, 'Diana', 103, 'Fall 2024', 'C'),
(5, 'Eve', 104, 'Fall 2024', 'B'),
(6, 'Frank', 101, 'Spring 2025', 'A'),
(7, 'Grace', 102, 'Spring 2025', 'B'),
(8, 'Heidi', 103, 'Spring 2025', 'A'),
(9, 'Ivan', 105, 'Spring 2025', 'C'),
(10, 'Judy', 105, 'Fall 2024', 'B');


SELECT * FROM enrollments ORDER BY student_name;

SELECT semester, COUNT(*) as total_students FROM enrollments GROUP BY semester;

SELECT grade, COUNT(*) as total_students FROM enrollments GROUP BY grade;

SELECT course_id, COUNT(*) as total_enrollments FROM enrollments GROUP BY course_id ORDER BY COUNT(*) DESC;

SELECT semester, grade, COUNT(*) as total_grade_per_sem FROM enrollments GROUP BY semester, grade;

SELECT AVG(student_count) FROM (
	SELECT course_id, COUNT(*) AS student_count FROM enrollments GROUP BY course_id
);

SELECT semester FROM enrollments WHERE grade = 'A' GROUP BY semester HAVING COUNT(*) > 1;

SELECT course_id, COUNT(*) FROM enrollments GROUP BY course_id HAVING COUNT(*) > 2;

SELECT grade, COUNT(*) FROM enrollments GROUP BY grade HAVING COUNT(*) > 1;

SELECT course_id, COUNT(*) FROM enrollments GROUP BY course_id ORDER BY COUNT(*) DESC LIMIT 3;




