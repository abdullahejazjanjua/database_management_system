SELECT * FROM school WHERE campus_name = 'Main Campus' ORDER BY school_name;

SELECT programme_code
FROM programme 
JOIN school ON programme.school_name = school.school_name
JOIN faculty ON school.faculty_name = faculty.faculty_name 
WHERE faculty.faculty_name = 'Science';

SELECT lecturer_name FROM lecturer 
JOIN commitee_lecturer ON lecturer.staff_id = commitee_lecturer.staff_id
ORDER BY lecturer_name;

SELECT S.lecturer_name AS supervisor_name, L.lecturer_name AS lecturer_name
FROM lecturer AS L
JOIN lecturer AS S ON L.staff_id = S.supervisor_id;


SELECT lecturer_name FROM lecturer WHERE staff_id NOT IN 
(
    SELECT staff_id FROM commitee_lecturer
);

SELECT programme_code, COUNT(*) FROM course GROUP BY programme_code;

SELECT lecturer_name, course.course_code, course.course_title FROM lecturer
JOIN lecturer_course ON lecturer.staff_id = lecturer_course.staff_id
JOIN course ON course.course_code = lecturer_course.course_code
ORDER BY lecturer_name; 

SELECT pre.course_title, cur.course_title
FROM course
JOIN pre_course AS pre ON pre.pre_course_code = course.course_code
JOIN pre_course AS cur ON cur.pre_course_code = course.course_code; 

SELECT pre.course_title, cur.course_title
FROM pre_course
JOIN course AS pre ON pre_course.pre_course_code = pre.course_code
JOIN course AS cur ON pre_course.course_code = cur.course_code;

SELECT course_code, COUNT(*) FROM course_student GROUP BY course_code ORDER BY COUNT(*) DESC LIMIT 5;

SELECT * FROM course_student;
SELECT * FROM pre_course;
