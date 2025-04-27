-- DO $$ <<label>>

--     DECLARE
--         -- Variables
--     BEGIN
--         -- Code logic

-- END <<label>> $$;


-- if <condition> then
-- elsif <condition> then
-- else 
-- end if


-- case variable
-- when value_1 then
-- do something
-- else  -> Default 
-- do something
-- end case;


-- while <condition> loop
-- do something
-- end loop;

SELECT * FROM employees;
-- Count the Number of employess with department Engineering


-- If else and Blocks
DO $$
    DECLARE
        count integer := 0;
    BEGIN
        SELECT COUNT(*) INTO count 
        FROM employees
        WHERE department = 'S';

        if count > 0 THEN
            RAISE NOTICE 'THe count is: %', count;
        else
            RAISE NOTICE 'No record found!!';
        end if;

END $$;

-- Row type variable -> Has column_names of the table

DO $$
    DECLARE 
        selected_employees employees%rowtype;
    BEGIN
        SELECT * INTO selected_employees
        FROM employees WHERE department = 'Engineering';

        if found then
            -- Picks only the first matched recored!!
            RAISE NOTICE 'firstname: %, lastname: %', selected_employees.first_name, selected_employees.last_name; 
        else
            RAISE NOTICE 'No such data';
        end if;
END $$;


-- Case statement
DO $$
    DECLARE
        department_emp employees.department%type;
        ch employees.department%type;
        
    BEGIN   
        SELECT department INTO department_emp 
        FROM employees
        WHERE employee_id = 1;

        case department_emp
            when 'Engineering' THEN
                ch = 'Eng';
            when 'Finance' THEN
                ch = 'Fin';
            when 'Marketing' THEN
                ch = 'Mkt';
            when 'Human Resources' THEN
                ch = 'HR';
            ELSE
                ch = 'None';
        end case;

        RAISE NOTICE 'Dep: %', ch;

END $$;


-- Searched Case statement
DO $$
    DECLARE
        salary_val INTEGER := 0;
        rank_emp VARCHAR(50);
    BEGIN   
        SELECT salary INTO salary_val 
        FROM employees
        WHERE employee_id = 2;

        case 
            when salary_val <= 70000 THEN
                rank_emp = 'Entry-level';
            when salary_val <= 80000 THEN
                rank_emp = 'Junior';
            when salary_val <= 90000 THEN
                rank_emp = 'Senior';
            else
                rank_emp = 'None';
        end case;

        RAISE NOTICE 'Rank: %', rank_emp;

END $$;


-- While loop
DO $$
    DECLARE 
        counter INTEGER := 0;
    BEGIN
        WHILE counter <= 5 loop
            RAISE NOTICE 'Count: %', counter;
            counter := counter + 1;
        end loop;
END $$;

-- Another way
DO $$
    DECLARE
        counter INTEGER := 0;
    BEGIN
        loop
            if counter > 5 then
                exit;
            end if;
            RAISE NOTICE 'Count: %', counter;
            counter := counter + 1;
        
        end loop;
END $$;

-- Tasks

-- Q1: 1.	Write a PL/pgSQL block to search for a student by id. 
-- If the student is found, return their name. Otherwise, raise an error stating that the student does not exist.

DO $$
    DECLARE 
        std_name student.name%type;
    BEGIN
        SELECT name INTO std_name
        FROM student
        WHERE id = 11;

        if found then
            RAISE NOTICE 'Name: %', std_name;
        else
            RAISE NOTICE 'Id not found';
        end if;
END $$;


-- Q2.	Write a PL/pgSQL block to find 
-- the GPA of a student using their id. If the GPA is greater than 3.00, print "Good"; otherwise, print "Bad".

DO $$
    DECLARE
        std_gpa student.GPA%type;
        remarks VARCHAR(5);
    BEGIN
        SELECT GPA INTO std_gpa
        FROM student
        WHERE id = 3;

        if std_gpa > 3.00 then
            remarks = 'Good';
        else
            remarks = 'Bad';
        end if;

        RAISE NOTICE 'Remarks: % on GPA %', remarks, std_gpa;
END $$;

-- Q3. Perform task 2 but now with case statement. 
DO $$
    DECLARE
        std_gpa student.GPA%type;
        remarks VARCHAR(5);
    BEGIN
        SELECT GPA INTO std_gpa
        FROM student
        WHERE id = 3;

        case
            when std_gpa > 3.00 then
                remarks = 'Good';
            else
                remarks = 'Bad';
        end case;

        RAISE NOTICE 'Remarks: % on GPA %', remarks, std_gpa;
END $$;

