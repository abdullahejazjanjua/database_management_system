DROP TABLE IF EXISTS customers, products, orders;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Data into Customers
INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Tom Lee');

-- Insert Data into Products
INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Laptop', 120),
(2, 'Smartphone', 80),
(3, 'Headphones', 200),
(4, 'Mouse', 30),
(5, 'Keyboard', 90);

-- Insert Data into Orders
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, 2, '2024-01-10'),
(2, 1, 2, 3, '2024-01-15'),
(3, 2, 1, 1, '2024-02-01'),
(4, 2, 2, 1, '2024-02-12'),
(5, 3, 5, 1, '2024-03-10');
