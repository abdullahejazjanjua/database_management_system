DROP TABLE IF EXISTS orders, products, customers, employees, departments CASCADE;

CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INT REFERENCES departments(dept_id),
    hire_date DATE NOT NULL,
    salary NUMERIC(10,2) NOT NULL CHECK (salary > 0)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    registered_on DATE DEFAULT CURRENT_DATE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0),
    stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    emp_id INT REFERENCES employees(emp_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    order_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO departments (dept_name) VALUES 
('Sales'), ('Support'), ('IT');

INSERT INTO employees (emp_name, dept_id, hire_date, salary) VALUES 
('Alice', 1, '2020-05-10', 50000),
('Bob', 1, '2021-02-15', 48000),
('Charlie', 2, '2022-08-20', 42000),
('Diana', 3, '2019-11-05', 60000);

INSERT INTO customers (customer_name, email, registered_on) VALUES 
('John Doe', 'john@example.com', '2023-01-01'),
('Jane Smith', 'jane@example.com', '2023-03-15'),
('Mike Ross', 'mike@example.com', '2024-02-28');

INSERT INTO products (product_name, price, stock_quantity) VALUES 
('Macbook', 2000, 90);
('Laptop', 1000, 50),
('Mouse', 25, 200),
('Monitor', 300, 80),
('Keyboard', 45, 150);

INSERT INTO orders (customer_id, product_id, emp_id, quantity, order_date) VALUES 
(1, 1, 1, 1, '2024-01-10'),
(1, 2, 1, 2, '2024-01-12'),
(2, 3, 2, 1, '2024-02-01'),
(3, 1, 3, 1, '2024-03-05'),
(2, 4, 4, 3, '2024-04-12');
