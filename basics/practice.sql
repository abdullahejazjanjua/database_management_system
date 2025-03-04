CREATE TABLE Student(
	RegNo INT PRIMARY KEY,
	Name Varchar(100),
	Age INT
);

CREATE TABLE Courses(
	CourseCode Varchar(100) PRIMARY KEY,
	CourseTitle Varchar(100),
	CreditHrs INT
);

CREATE TABLE EnrolledCourses(
	StudentID INT,
	CourseID Varchar(100),
	CONSTRAINT fk_student FOREIGN KEY(StudentID) REFERENCES Student(RegNo),
	CONSTRAINT fk_courses FOREIGN KEY(CourseID) REFERENCES Courses(CourseCode)
);

INSERT INTO Student(RegNO, Name, Age) VALUES
(2023038, 'Abdullah Ejaz Janjua', 19),
(2023001, 'Ali Khan', 20),
(2023002, 'Fatima Tariq', 21),
(2023003, 'Hassan Raza', 22),
(2023004, 'Zainab Ahmed', 19),
(2023005, 'Usman Iqbal', 23);

INSERT INTO Courses (CourseCode, CourseTitle, CreditHrs) VALUES
('CS101', 'Introduction to Programming', 3),
('CS102', 'Data Structures', 4),
('CS103', 'Computer Vision', 3),
('CS104', 'Machine Learning', 4),
('CS105', 'Database Systems', 3);

INSERT INTO EnrolledCourses (StudentID, CourseID) VALUES
(2023001, 'CS101'),
(2023001, 'CS102'),
(2023002, 'CS103'),
(2023003, 'CS104'),
(2023004, 'CS105'),
(2023005, 'CS101'),
(2023005, 'CS104'),
(2023038, 'CS103');


SELECT * FROM Student;
SELECT * FROM Courses;
SELECT * FROM EnrolledCourses;

SELECT * FROM Student WHERE Name LIKE '%A';
SELECT * FROM Student WHERE LENGTH(Name) BETWEEN 2 AND 30;
SELECT Name AS "Naam" FROM Student;
SELECT * FROM EnrolledCourses;

-- Joins All Tables in every possible combination way. The Where Condition Keeps those rows that exists in
-- EnrolledCourses Table
-- Run each part separately 
SELECT RegNo, Name FROM Student, Courses, EnrolledCourses WHERE 
EnrolledCourses.StudentID = Student.RegNo 
AND 
EnrolledCourses.CourseID = Courses.CourseCode;

-- Now, Do the same as above but instead Group By courseTitle (Distinct Entries) and the count each times it 
-- appears in the joined table
SELECT CourseTitle, COUNT(CourseTitle) FROM Student, Courses, EnrolledCourses WHERE 
EnrolledCourses.StudentID = Student.RegNo 
AND 
EnrolledCourses.CourseID = Courses.CourseCode GROUP BY CourseTitle;


-- Update commands finds by WHERE and uses SET change
UPDATE Student SET Name = 'Janjua' WHERE RegNo = 2023038;
UPDATE Student SET RegNo = 2023999 WHERE Name = 'Janjua'; -- Gives Error as the RegNo is used in a relation in EnrolledCourses

-- Delete commands finds by WHERE and then Removes
DELETE FROM Student WHERE name = 'Janjua'; -- Gives error as this entry is used in a relation in Enrolled Courses



-- Deletes table. Good when small entires. 
DROP TABLE Student; -- Gives error due to relation. Use Cascade to delete the relation
DROP TABLE Student CASCADE; -- This will remove the foreign Key constraint and allow for deletion

-- Deletes entire table efficiently. Used when too many entires
TRUNCATE TABLE Student; 

-- Adding a column
ALTER TABLE Student ADD COLUMN Aura INT CHECK(Aura <= 100);
UPDATE Student SET Aura = 100 WHERE RegNo = 2023038; -- I am the King!
UPDATE Student Set Aura = -100000000 WHERE RegNo != 2023038;


-- Changing column name
ALTER TABLE Student RENAME COLUMN Name TO full_name;
ALTER TABLE Student RENAME COLUMN aura TO "Aura", RENAME COLUMN full_name TO name; -- Sir Ahsan Shah Asked to rename mutiple columns in one command which isnt possible

-- Adding contraints
ALTER TABLE Student ALTER COLUMN full_name SET NOT NULL;

ALTER TABLE Student ADD CHECK (LENGTH(name) > 3);

ALTER TABLE EnrolledCourses ADD CONSTRAINT fk_student FOREIGN KEY(StudentID) REFERENCES Student(RegNo);

DROP DATABASE postgres;

SELECT pg_terminate_backend(14044);
