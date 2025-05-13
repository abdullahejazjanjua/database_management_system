-- Create the transactions table
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    amount DECIMAL(10, 2)
);

-- Insert sample data into transactions table
INSERT INTO transactions (customer_id, transaction_date, amount) VALUES
(1, '2025-01-01', 100.50),
(1, '2025-01-15', 200.75),
(2, '2025-01-10', 150.00),
(2, '2025-01-20', 250.25),
(3, '2025-01-05', 300.00),
(3, '2025-01-25', 350.50),
(4, '2025-01-12', 400.00),
(4, '2025-01-18', 450.75),
(5, '2025-01-07', 500.00);



DROP TABLE transactions;