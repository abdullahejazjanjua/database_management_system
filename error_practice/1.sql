-- Create a database for a small online bookstore
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    birth_year DATE,
    country VARCHAR(50)
);

DROP TABLE Authors;

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    publication_year INT,
    price DECIMAL(5,2),
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE DEFAULT CURRENT_DATE,
    total_amount DECIMAL(8,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderItems (
    order_id INT,
    book_id INT,
    quantity INT DEFAULT 1,
    item_price DECIMAL(6,2),
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert Authors
INSERT INTO Authors (author_id, author_name, birth_year, country)
VALUES 
    (1, 'Jane Austen', '1775-12-16', 'England'),
    (2, 'George Orwell', '1903-06-25', 'England'),
    (3, 'Gabriel García Márquez', '1927-03-06', 'Colombia');

-- Insert Books
INSERT INTO Books (book_id, title, publication_year, price, author_id)
VALUES 
    (101, 'Pride and Prejudice', 1813, 12.99, 1),
    (102, '1984', 1949, 14.50, 2),
    (103, 'Animal Farm', 1945, 11.75, 2),
    (104, 'One Hundred Years of Solitude', 1967, 15.99, 3);

-- Insert Customers
INSERT INTO Customers (customer_id, first_name, last_name, email, phone)
VALUES 
    (1001, 'John', 'Smith', 'john.smith@email.com', '555-123-4567'),
    (1002, 'Emma', 'Johnson', 'emma.j@email.com', '555-987-6543'),
    (1003, 'Michael', 'Brown', NULL, '555-456-7890');

-- Insert Orders
INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES 
    (10001, 1001, '2023-06-15', 27.49),
    (10002, 1002, '2023-06-16', 15.99),
    (10003, 1003, '2023-06-17', 26.25);

-- Insert OrderItems
INSERT INTO OrderItems (order_id, book_id, quantity, item_price)
VALUES 
    (10001, 101, 1, 12.99),
    (10001, 102, 1, 14.50),
    (10002, 104, 1, 15.99),
    (10003, 102, 1, 14.50),
    (10003, 103, 1, 11.75);