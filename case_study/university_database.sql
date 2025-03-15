CREATE TABLE campus(
    campus_name VARCHAR(20) PRIMARY KEY,
    addrs VARCHAR(50),
    dist NUMERIC(8, 2),
    bus_no VARCHAR(20)
);

CREATE TABLE club(
    club_name VARCHAR(20) PRIMARY KEY,
    campus_name VARCHAR(20),
    club_building VARCHAR(20),
    club_phone_no VARCHAR(20),
    CONSTRAINT fk_campus FOREIGN KEY(campus_name) REFERENCES campus(campus_name)
);

CREATE TABLE sport(
    sport_name VARCHAR(20) PRIMARY KEY,
    club_name VARCHAR(20),
    CONSTRAINT fk_club FOREIGN KEY(club_name) REFERENCES club(club_name)
);

CREATE TABLE faculty(
    faculty_name VARCHAR(20) PRIMARY KEY,
    dean_name VARCHAR(20),
    faculty_building VARCHAR(20)
);

CREATE TABLE school(
    school_name VARCHAR(20) PRIMARY KEY,
    faculty_name VARCHAR(20),
    campus_name VARCHAR(20),
    school_building VARCHAR(20),
    CONSTRAINT fk_faculty FOREIGN KEY(faculty_name) REFERENCES faculty(faculty_name),
    CONSTRAINT fk_campus FOREIGN KEY(campus_name) REFERENCES campus(campus_name)
);

CREATE TABLE programme(
    programme_code VARCHAR(11) PRIMARY KEY,
    School_name VARCHAR(20),
    programme_title VARCHAR(20),
    programme_level VARCHAR(20),
    programme_lenght VARCHAR(20),
    CONSTRAINT fk_school FOREIGN KEY(school_name) REFERENCES school(school_name)
);

CREATE TABLE student(
    student_ID INT PRIMARY KEY,
    programme_code VARCHAR(11),
    student_name VARCHAR(20),
    student_birthdate DATE,
    year_enrolled DATE,
    CONSTRAINT fk_programme FOREIGN KEY(programme_code) REFERENCES programme(programme_code)
);

CREATE TABLE lecturer(
    staff_id INT PRIMARY KEY,
    school_name VARCHAR(20),
    supervisor_id INT,
    lecturer_name VARCHAR(20),
    lecturer_title VARCHAR(20),
    office_room VARCHAR(20),
    CONSTRAINT fk_lecturer FOREIGN KEY(supervisor_id) REFERENCES lecturer(staff_id),
    CONSTRAINT fk_school FOREIGN KEY(school_name) REFERENCES school(school_name)
);

CREATE TABLE commitee(
    commitee_title VARCHAR(20) PRIMARY KEY,
    faculty_name VARCHAR(20),
    meeting_freg INT,
    CONSTRAINT fk_faculty FOREIGN KEY(faculty_name) REFERENCES faculty(faculty_name)
);

CREATE TABLE commitee_lecturer(
    staff_id INT,
    commitee_title VARCHAR(20),
    faculty_name VARCHAR(20),
    CONSTRAINT fk_faculty FOREIGN KEY(faculty_name) REFERENCES faculty(faculty_name),
    CONSTRAINT fk_lecturer FOREIGN KEY(staff_id) REFERENCES lecturer(staff_id),
    CONSTRAINT fk_commitee FOREIGN KEY(commitee_title) REFERENCES commitee(commitee_title)
);

CREATE TABLE course(
    course_code VARCHAR(11) PRIMARY KEY,
    course_title VARCHAR(20),
    programme_code VARCHAR(11),
    CONSTRAINT fk_programme FOREIGN KEY(programme_code) REFERENCES programme(programme_code)
   

)

CREATE TABLE lecturer_course(
    staff_id INT,
    course_code VARCHAR(11),
    CONSTRAINT fk_lecturer FOREIGN KEY(staff_id) REFERENCES lecturer(staff_id),
    CONSTRAINT fk_course FOREIGN KEY(course_code) REFERENCES course(course_code)
);

CREATE TABLE pre_course(
    course_code VARCHAR(11),
    pre_course_code VARCHAR(11),
    CONSTRAINT fk_course FOREIGN KEY(course_code) REFERENCES course(course_code),
    CONSTRAINT fk_pre_course FOREIGN KEY(pre_course_code) REFERENCES course(course_code)
);

CREATE TABLE course_student(
    course_code VARCHAR(11),
    student_ID INT,
    year_taken DATE,
    semester_taken VARCHAR(20),
    grade_awared VARCHAR(2),
    CONSTRAINT fk_student FOREIGN KEY(student_ID) REFERENCES student(student_ID)
);
