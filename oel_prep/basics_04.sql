CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20)
);

DROP TABLE orders;

INSERT INTO orders (order_id, customer_name, order_date, amount, status) VALUES
(1, 'Alice', '2024-01-10', 250.00, 'Shipped'),
(2, 'Bob', '2024-01-12', 75.50, 'Pending'),
(3, 'Charlie', '2024-01-12', 120.00, 'Cancelled'),
(4, 'Alice', '2024-01-15', 310.00, 'Shipped'),
(5, 'David', '2024-01-16', 99.99, 'Pending'),
(6, 'Eve', '2024-01-17', 450.25, 'Shipped'),
(7, 'Bob', '2024-01-18', 200.00, 'Shipped'),
(8, 'Frank', '2024-01-19', 150.75, 'Pending'),
(9, 'Charlie', '2024-01-20', 89.90, 'Shipped'),
(10, 'Grace', '2024-01-21', 330.00, 'Cancelled');


SELECT DISTINCT customer_name FROM orders WHERE customer_name IN (
	SELECT customer_name FROM orders WHERE status = 'Cancelled' 
	GROUP BY customer_name HAVING COUNT(*) >= 1
);

SELECT * FROM orders WHERE amount > (
	SELECT AVG(amount) FROM orders
)

SELECT DISTINCT customer_name FROM orders AS O1 WHERE EXISTS (
	SELECT 1 FROM orders as O2 WHERE order_date = '2024-01-12'
	AND O1.order_id = O2.order_id
)



SELECT DISTINCT customer_name FROM orders WHERE customer_name IN (
	SELECT customer_name FROM orders 
	GROUP BY customer_name HAVING COUNT(*) > 1
);

SELECT DISTINCT customer_name FROM orders AS O1 WHERE EXISTS (
	SELECT 1 FROM orders AS O2 WHERE
	O2.customer_name = O1.customer_name AND
	O1.order_id != O2.order_id
)




SELECT * FROM orders WHERE amount > ANY(
	SELECT amount FROM orders WHERE customer_name = 'Bob'
);


SELECT * FROM orders WHERE amount > ALL(
	SELECT amount FROM orders WHERE customer_name = 'Charlie'
);

SELECT * FROM orders AS O1 WHERE amount = (
	SELECT MAX(amount) FROM orders AS O2 
	WHERE O2.customer_name = O1.customer_name
)

SELECT DISTINCT O1.customer_name FROM orders AS O1 WHERE NOT EXISTS(
	SELECT 1 FROM orders AS O2 
	WHERE O1.customer_name = O2.customer_name 
	AND 
	(status = 'Pending' OR status = 'Cancelled')
);

SELECT * FROM orders WHERE order_date IN (
	SELECT order_date FROM orders WHERE customer_name = 'Alice'
);

SELECT customer_name FROM orders GROUP BY customer_name
HAVING SUM(amount) >= ALL(
	SELECT SUM(amount) FROM orders 
	GROUP BY customer_name
);


SELECT DISTINCT customer_name FROM orders AS O1
WHERE amount > (
	SELECT AVG(amount) FROM orders AS O2
	WHERE O2.status = O2.status
)


SELECT DISTINCT customer_name FROM orders 
WHERE customer_name NOT IN (
	SELECT customer_name FROM orders 
	WHERE amount = (SELECT MAX(amount) FROM orders)
);



