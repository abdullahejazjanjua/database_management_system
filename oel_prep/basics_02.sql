CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor VARCHAR(100),
    credits INT,
    department VARCHAR(50)
);

INSERT INTO courses (course_id, course_name, instructor, credits, department) VALUES
(101, 'Intro to Programming', 'Dr. Smith', 3, 'Computer Science'),
(102, 'Data Structures', 'Dr. Allen', 4, 'Computer Science'),
(103, 'Calculus I', 'Dr. Newton', 4, 'Mathematics'),
(104, 'English Literature', 'Dr. Clarke', 3, 'Humanities'),
(105, 'Physics I', 'Dr. Feynman', 4, 'Physics');


SELECT * FROM courses;

SELECT course_name, instructor FROM courses;

SELECT * FROM courses WHERE credits > 3;

SELECT * FROM courses WHERE department = 'Computer Science';

SELECT COUNT(*) AS total_courses FROM courses;

SELECT DISTINCT department FROM courses;

UPDATE courses SET instructor = 'John Doe' WHERE course_id = 101;

UPDATE courses SET credits = credits + 1 WHERE course_name = 'Data Structures';

UPDATE courses SET department = 'Physical Sciences' WHERE department = 'Physics';

DELETE FROM courses WHERE course_id = 104;

DELETE FROM courses WHERE credits < 4;

DROP TABLE courses;

