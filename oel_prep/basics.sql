CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT,
    grade CHAR(1),
    enrollment_date DATE
);


ALTER TABLE students RENAME COLUMN name TO full_name;

ALTER TABLE students ALTER COLUMN age TYPE SMALLINT;

ALTER TABLE students ADD COLUMN email VARCHAR(255);

ALTER TABLE students DROP COLUMN grade;

ALTER TABLE students ALTER COLUMN full_name SET NOT NULL;

ALTER TABLE students ADD CONSTRAINT pk_students PRIMARY KEY(id);

ALTER TABLE students ADD CONSTRAINT unique_email UNIQUE(email);

ALTER TABLE students ADD CHECK (age > 0);

ALTER TABLE students ADD COLUMN grade CHAR(1);

ALTER TABLE students ALTER COLUMN grade SET DEFAULT 'C';

DROP TABLE students;