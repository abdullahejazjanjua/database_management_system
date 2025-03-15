-- Inserting data into campus table BY CLAUDE to save time
INSERT INTO campus VALUES ('Main Campus', '123 University Ave, City', 0.00, 'Route 1, 2, 3');
INSERT INTO campus VALUES ('North Campus', '456 College Blvd, North City', 5.75, 'Route 5, 8');
INSERT INTO campus VALUES ('South Campus', '789 Academy St, South City', 8.25, 'Route 7, 10, 12');
INSERT INTO campus VALUES ('Downtown Campus', '101 Urban Plaza, Downtown', 3.50, 'Route 4, 6, 15');

-- Inserting data into club table
INSERT INTO club VALUES ('Chess Club', 'Main Campus', 'Student Center', '555-1234');
INSERT INTO club VALUES ('Debate Society', 'Main Campus', 'Liberal Arts', '555-2345');
INSERT INTO club VALUES ('Photography Club', 'North Campus', 'Arts Building', '555-3456');
INSERT INTO club VALUES ('Drama Club', 'South Campus', 'Theater Hall', '555-4567');
INSERT INTO club VALUES ('Robotics Club', 'Downtown Campus', 'Engineering Hall', '555-5678');

-- Inserting data into sport table
INSERT INTO sport VALUES ('Basketball', 'Chess Club');
INSERT INTO sport VALUES ('Soccer', 'Debate Society');
INSERT INTO sport VALUES ('Swimming', 'Photography Club');
INSERT INTO sport VALUES ('Tennis', 'Drama Club');
INSERT INTO sport VALUES ('Baseball', 'Robotics Club');

-- Inserting data into faculty table
INSERT INTO faculty VALUES ('Engineering', 'Dr. James Smith', 'Engineering Tower');
INSERT INTO faculty VALUES ('Science', 'Dr. Maria Garcia', 'Science Complex');
INSERT INTO faculty VALUES ('Arts', 'Dr. Robert Johnson', 'Arts Center');
INSERT INTO faculty VALUES ('Business', 'Dr. Sarah Williams', 'Business Building');
INSERT INTO faculty VALUES ('Medicine', 'Dr. Michael Brown', 'Medical Center');

-- Inserting data into school table
INSERT INTO school VALUES ('Computer Science', 'Engineering', 'Main Campus', 'Tech Building');
INSERT INTO school VALUES ('Chemistry', 'Science', 'North Campus', 'Lab Building');
INSERT INTO school VALUES ('Fine Arts', 'Arts', 'South Campus', 'Gallery Building');
INSERT INTO school VALUES ('Marketing', 'Business', 'Downtown Campus', 'Commerce Building');
INSERT INTO school VALUES ('Nursing', 'Medicine', 'Main Campus', 'Health Building');

-- Inserting data into programme table
INSERT INTO programme VALUES ('CS101', 'Computer Science', 'Computer Science', 'Bachelor', '4 years');
INSERT INTO programme VALUES ('CH202', 'Chemistry', 'Chemistry', 'Bachelor', '3 years');
INSERT INTO programme VALUES ('FA303', 'Fine Arts', 'Fine Arts', 'Bachelor', '3 years');
INSERT INTO programme VALUES ('MK404', 'Marketing', 'Marketing', 'Master', '2 years');
INSERT INTO programme VALUES ('NR505', 'Nursing', 'Nursing', 'Bachelor', '4 years');

-- Inserting data into student table
INSERT INTO student VALUES (10001, 'CS101', 'Alex Johnson', '2000-05-15', '2020-09-01');
INSERT INTO student VALUES (10002, 'CH202', 'Emma Williams', '2001-07-22', '2021-09-01');
INSERT INTO student VALUES (10003, 'FA303', 'Daniel Brown', '1999-03-10', '2019-09-01');
INSERT INTO student VALUES (10004, 'MK404', 'Sophia Davis', '1998-11-05', '2022-01-15');
INSERT INTO student VALUES (10005, 'NR505', 'Oliver Wilson', '2002-01-30', '2022-09-01');

-- Inserting data into lecturer table
INSERT INTO lecturer VALUES (20001, 'Computer Science', NULL, 'Dr. Alan Turing', 'Professor', 'CS-101');
INSERT INTO lecturer VALUES (20002, 'Chemistry', NULL, 'Dr. Marie Curie', 'Professor', 'CH-201');
INSERT INTO lecturer VALUES (20003, 'Fine Arts', NULL, 'Dr. Pablo Picasso', 'Professor', 'FA-301');
INSERT INTO lecturer VALUES (20004, 'Marketing', NULL, 'Dr. Philip Kotler', 'Professor', 'MK-401');
INSERT INTO lecturer VALUES (20005, 'Nursing', NULL, 'Dr. Florence Night', 'Professor', 'NR-501');
INSERT INTO lecturer VALUES (20006, 'Computer Science', 20001, 'Dr. Ada Lovelace', 'Associate Professor', 'CS-102');
INSERT INTO lecturer VALUES (20007, 'Chemistry', 20002, 'Dr. Louis Pasteur', 'Assistant Professor', 'CH-202');
INSERT INTO lecturer VALUES (20008, 'Fine Arts', 20003, 'Dr. Vincent van Gogh', 'Lecturer', 'FA-302');
INSERT INTO lecturer VALUES (20009, 'Marketing', 20004, 'Dr. Steve Jobs', 'Associate Professor', 'MK-402');
INSERT INTO lecturer VALUES (20010, 'Nursing', 20005, 'Dr. Clara Barton', 'Assistant Professor', 'NR-502');

-- Inserting data into commitee table
INSERT INTO commitee VALUES ('Academic Affairs', 'Engineering', 4);
INSERT INTO commitee VALUES ('Research', 'Science', 2);
INSERT INTO commitee VALUES ('Cultural Events', 'Arts', 6);
INSERT INTO commitee VALUES ('Budget', 'Business', 12);
INSERT INTO commitee VALUES ('Healthcare', 'Medicine', 4);

-- Inserting data into commitee_lecturer table
INSERT INTO commitee_lecturer VALUES (20001, 'Academic Affairs', 'Engineering');
INSERT INTO commitee_lecturer VALUES (20002, 'Research', 'Science');
INSERT INTO commitee_lecturer VALUES (20003, 'Cultural Events', 'Arts');
INSERT INTO commitee_lecturer VALUES (20004, 'Budget', 'Business');
INSERT INTO commitee_lecturer VALUES (20005, 'Healthcare', 'Medicine');
INSERT INTO commitee_lecturer VALUES (20006, 'Academic Affairs', 'Engineering');
INSERT INTO commitee_lecturer VALUES (20007, 'Research', 'Science');
INSERT INTO commitee_lecturer VALUES (20008, 'Cultural Events', 'Arts');
INSERT INTO commitee_lecturer VALUES (20009, 'Budget', 'Business');
INSERT INTO commitee_lecturer VALUES (20010, 'Healthcare', 'Medicine');

-- Inserting data into course table
INSERT INTO course VALUES ('COMP101', 'Intro to Programming', 'CS101');
INSERT INTO course VALUES ('CHEM101', 'General Chemistry', 'CH202');
INSERT INTO course VALUES ('ART101', 'Drawing Basics', 'FA303');
INSERT INTO course VALUES ('MKT101', 'Marketing Principles', 'MK404');
INSERT INTO course VALUES ('NUR101', 'Nursing Fundamentals', 'NR505');
INSERT INTO course VALUES ('COMP201', 'Data Structures', 'CS101');
INSERT INTO course VALUES ('CHEM201', 'Organic Chemistry', 'CH202');
INSERT INTO course VALUES ('ART201', 'Painting', 'FA303');
INSERT INTO course VALUES ('MKT201', 'Market Research', 'MK404');
INSERT INTO course VALUES ('NUR201', 'Medical Ethics', 'NR505');

-- Inserting data into lecturer_course table
INSERT INTO lecturer_course VALUES (20001, 'COMP101');
INSERT INTO lecturer_course VALUES (20002, 'CHEM101');
INSERT INTO lecturer_course VALUES (20003, 'ART101');
INSERT INTO lecturer_course VALUES (20004, 'MKT101');
INSERT INTO lecturer_course VALUES (20005, 'NUR101');
INSERT INTO lecturer_course VALUES (20006, 'COMP201');
INSERT INTO lecturer_course VALUES (20007, 'CHEM201');
INSERT INTO lecturer_course VALUES (20008, 'ART201');
INSERT INTO lecturer_course VALUES (20009, 'MKT201');
INSERT INTO lecturer_course VALUES (20010, 'NUR201');

-- Inserting data into pre_course table
INSERT INTO pre_course VALUES ('COMP201', 'COMP101');
INSERT INTO pre_course VALUES ('CHEM201', 'CHEM101');
INSERT INTO pre_course VALUES ('ART201', 'ART101');
INSERT INTO pre_course VALUES ('MKT201', 'MKT101');
INSERT INTO pre_course VALUES ('NUR201', 'NUR101');

-- Inserting data into course_student table
INSERT INTO course_student VALUES ('COMP101', 10001, '2020-09-01', 'Fall', 'A');
INSERT INTO course_student VALUES ('CHEM101', 10002, '2021-09-01', 'Fall', 'B+');
INSERT INTO course_student VALUES ('ART101', 10003, '2019-09-01', 'Fall', 'A-');
INSERT INTO course_student VALUES ('MKT101', 10004, '2022-01-15', 'Spring', 'B');
INSERT INTO course_student VALUES ('NUR101', 10005, '2022-09-01', 'Fall', 'A+');
INSERT INTO course_student VALUES ('COMP201', 10001, '2021-01-15', 'Spring', 'B+');
INSERT INTO course_student VALUES ('CHEM201', 10002, '2022-01-15', 'Spring', 'B');
INSERT INTO course_student VALUES ('ART201', 10003, '2020-01-15', 'Spring', 'A');
INSERT INTO course_student VALUES ('MKT201', 10004, '2022-09-01', 'Fall', 'A-');
INSERT INTO course_student VALUES ('NUR201', 10005, '2023-01-15', 'Spring', 'A');