-- Create Departments Table
CREATE TABLE Departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

-- Insert sample data into Departments
INSERT INTO Departments (dept_name, location) VALUES
('HR', 'New York'),
('IT', 'San Francisco'),
('Finance', 'Chicago'),
('Marketing', 'Los Angeles');

-- Create Employees Table
CREATE TABLE Employees (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dept_id INT,
    salary INT,
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE CASCADE
);

-- Insert sample data into Employees
INSERT INTO Employees (first_name, last_name, dept_id, salary, hire_date) VALUES
('Muhammad', 'Zayan', NULL, 10000, '2025-01-15');
('John', 'Doe', 1, 60000, '2019-01-15'),
('Jane', 'Smith', 2, 80000, '2018-06-25'),
('Alice', 'Johnson', 3, 75000, '2020-02-11'),
('Bob', 'Brown', 4, 90000, '2021-03-22'),
('Charlie', 'Davis', 2, 95000, '2017-09-30');

-- Create Projects Table
CREATE TABLE Projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE
);


-- Insert sample data into Projects
INSERT INTO Projects (project_name, start_date, end_date) VALUES
('Project Alpha', '2023-01-01', '2023-06-01'),
('Project Beta', '2023-03-15', '2023-12-15'),
('Project Gamma', '2023-05-01', '2024-01-01');

-- Create Employee_Project_Assignment Table
CREATE TABLE Employee_Project_Assignment (
    emp_id INT,
    project_id INT,
    role VARCHAR(100),
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);

-- Insert sample data into Employee_Project_Assignment
INSERT INTO Employee_Project_Assignment (emp_id, project_id, role, start_date, end_date) VALUES
(6, NULL, 'Janitor',  '2023-01-01', '2023-06-01');
(1, 1, 'Manager', '2023-01-01', '2023-06-01'),
(2, 2, 'Developer', '2023-03-15', '2023-12-15'),
(3, 1, 'Analyst', '2023-01-01', '2023-06-01'),
(4, 3, 'Lead', '2023-05-01', '2024-01-01'),
(5, 2, 'Senior Developer', '2023-03-15', '2023-12-15');

-- Create Salaries Table
CREATE TABLE Salaries (
    emp_id INT,
    salary INT,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (emp_id, start_date),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id) ON DELETE CASCADE
);

-- Insert sample data into Salaries
INSERT INTO Salaries (emp_id, salary, start_date, end_date) VALUES
(1, 60000, '2019-01-15', '2020-01-15'),
(2, 80000, '2018-06-25', '2019-06-25'),
(3, 75000, '2020-02-11', '2021-02-11'),
(4, 90000, '2021-03-22', '2022-03-22'),
(5, 95000, '2017-09-30', '2018-09-30');
