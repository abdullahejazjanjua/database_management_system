-- Table for storing customer information
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE DEFAULT CURRENT_DATE
);

-- Table for storing product information
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0)
);

-- Table for storing customer orders
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id),
    product_id INT REFERENCES Products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for logging actions on Orders table (used in trigger task)
CREATE TABLE AuditLog (
    log_id SERIAL PRIMARY KEY,
    order_id INT,
    action VARCHAR(50),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample customers
INSERT INTO Customers (name, email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com');

-- Insert sample products
INSERT INTO Products (name, price, stock) VALUES
('Laptop', 1200.00, 10),
('Mouse', 25.00, 50),
('Keyboard', 45.00, 30);

-- Insert sample orders
INSERT INTO Orders (customer_id, product_id, quantity) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1);
