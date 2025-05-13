-- Find customers who have ordered all products that cost more than $100.

SELECT customer_name FROM customers WHERE customer_id IN (
	SELECT customer_id FROM orders WHERE product_id IN (
		SELECT DISTINCT product_id FROM products WHERE price > 100
			)
	GROUP BY customer_id HAVING COUNT(DISTINCT product_id) = ( 
		SELECT COUNT(DiSTINCT product_id) FROM products WHERE price > 100
		)
);

-- Get the names of employees who handled orders for more than one distinct customer.

SELECT emp_name FROM employees WHERE emp_id IN (
	SELECT emp_id AS count_cust_id FROM orders GROUP BY emp_id HAVING COUNT(DISTINCT customer_id) > 1
);

-- List departments where the average salary of employees is higher than the overall average salary.

SELECT dept_name FROM departments WHERE dept_id IN (
	SELECT dept_id FROM employees GROUP BY dept_id
	HAVING AVG(salary) > ( SELECT AVG(salary) FROM employees)
);

-- Display products that were never ordered OR were only ordered by a single customer.

SELECT product_name FROM products WHERE product_id NOT IN (
		SELECT product_id FROM products
	)
	OR product_id IN (
		SELECT product_id FROM orders GROUP BY product_id HAVING COUNT(DISTINCT customer_id) = 1
	)
;


-- Show the name of the customer(s) who spent the most in total (quantity × price).

SELECT customer_name FROM customers WHERE customer_id IN (

	SELECT customer_id
	FROM orders 
	JOIN products ON products.product_id = orders.product_id 
	GROUP BY customer_id HAVING SUM(quantity * price) = (
	SELECT MAX(total) FROM (
		SELECT SUM(quantity * price) as total
		FROM orders 
		JOIN products ON products.product_id = orders.product_id 
		GROUP BY customer_id
		)
	)
);

-- Find the most recent order for each customer and the employee who handled it.

SELECT O1.customer_id, O1.emp_id, O1.order_date FROM orders AS O1 WHERE order_date = (
	SELECT MAX(O2.order_date) FROM orders AS O2 
	WHERE O2.customer_id = O1.customer_id 
	GROUP BY O2.customer_id
);

-- Display the top 2 departments (by name) with the most active employees (who handled at least one order).

SELECT DISTINCT departments.dept_name FROM employees
JOIN departments ON departments.dept_id = employees.dept_id
JOIN (
	SELECT emp_id FROM orders GROUP BY emp_id HAVING COUNT(*) >= 1 ORDER BY COUNT(*) DESC LIMIT 2
) top_emps ON top_emps.emp_id = employees.emp_id ;

-- List customers who have placed orders handled by employees outside the 'Sales' department.

SELECT customer_name FROM customers WHERE customer_id IN (
	SELECT DISTINCT customer_id FROM orders WHERE emp_id NOT IN (
		SELECT employees.emp_id FROM employees JOIN departments ON departments.dept_id = employees.dept_id 
		WHERE departments.dept_name = 'Sales'
	)
);

-- Find employees who haven’t handled any orders in the last 3 months.

SELECT emp_name FROM employees WHERE emp_id NOT IN (
	SELECT emp_id 
	FROM orders 
	WHERE order_date >= (SELECT MAX(order_date) - INTERVAL '3 months' FROM orders)
	  AND order_date <= (SELECT MAX(order_date) FROM orders)
);


-- For each customer, show the first product they ever ordered (by order_date).

SELECT DISTINCT O1.customer_id, O1.product_id FROM orders AS O1 WHERE O1.order_date IN (
	SELECT MIN(order_date) FROM orders AS O2
	WHERE O1.customer_id = O2.customer_id
	GROUP BY O2.customer_id
)

