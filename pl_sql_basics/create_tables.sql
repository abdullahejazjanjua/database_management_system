-- Create a sample employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary NUMERIC(10, 2),
    hire_date DATE
);

-- Insert some sample data
INSERT INTO employees (first_name, last_name, department, salary, hire_date) VALUES
    ('John', 'Smith', 'Engineering', 75000.00, '2020-03-15'),
    ('Sarah', 'Jones', 'Marketing', 65000.00, '2019-11-01'),
    ('Michael', 'Brown', 'Engineering', 82000.00, '2018-06-22'),
    ('Emily', 'Davis', 'Human Resources', 62000.00, '2021-01-10'),
    ('Robert', 'Wilson', 'Finance', 88000.00, '2017-09-05'),
    ('Jennifer', 'Taylor', 'Marketing', 70000.00, '2020-07-18'),
    ('David', 'Miller', 'Engineering', 79000.00, '2019-04-30'),
    ('Lisa', 'Anderson', 'Human Resources', 59000.00, '2022-02-14'),
    ('James', 'Thomas', 'Finance', 90000.00, '2016-10-25'),
    ('Patricia', 'Jackson', 'Marketing', 68000.00, '2021-05-03');

-- Create a projects table for relations
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    budget NUMERIC(12, 2),
    status VARCHAR(20)
);

-- Insert project data
INSERT INTO projects (project_name, start_date, end_date, budget, status) VALUES
    ('Website Redesign', '2023-01-15', '2023-04-30', 150000.00, 'Completed'),
    ('Mobile App Development', '2023-03-01', '2023-08-31', 300000.00, 'In Progress'),
    ('Database Migration', '2023-05-10', '2023-07-15', 120000.00, 'In Progress'),
    ('Marketing Campaign', '2023-02-01', '2023-05-31', 200000.00, 'Completed'),
    ('Cloud Infrastructure', '2023-06-01', '2023-12-31', 500000.00, 'Not Started');

-- Create a junction table for employees and projects
CREATE TABLE employee_projects (
    employee_id INTEGER REFERENCES employees(employee_id),
    project_id INTEGER REFERENCES projects(project_id),
    role VARCHAR(50),
    hours_allocated INTEGER,
    PRIMARY KEY (employee_id, project_id)
);

-- Assign employees to projects
INSERT INTO employee_projects (employee_id, project_id, role, hours_allocated) VALUES
    (1, 1, 'Developer', 120),
    (3, 1, 'Lead Developer', 160),
    (7, 1, 'Developer', 100),
    (2, 4, 'Marketing Specialist', 140),
    (6, 4, 'Marketing Lead', 180),
    (10, 4, 'Content Creator', 120),
    (5, 3, 'Financial Analyst', 80),
    (9, 3, 'Project Manager', 100),
    (4, 2, 'HR Coordinator', 60),
    (8, 2, 'Recruiter', 40);

DROP TABLE employees CASCADE;
DROP TABLE employee_projects CASCADE;
DROP TABLE projects CASCADE;

CREATE TABLE student (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    GPA NUMERIC(3,2) CHECK (GPA BETWEEN 0.00 AND 4.00)
);

INSERT INTO student (id, name, GPA) VALUES (1, 'Alice Johnson', 3.75);
INSERT INTO student (id, name, GPA) VALUES (2, 'Bob Smith', 3.20);
INSERT INTO student (id, name, GPA) VALUES (3, 'Charlie Brown', 2.85);
INSERT INTO student (id, name, GPA) VALUES (4, 'David Wilson', 3.90);
INSERT INTO student (id, name, GPA) VALUES (5, 'Emma Davis', 3.50);
