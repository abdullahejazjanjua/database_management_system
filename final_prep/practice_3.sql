DROP TABLE customers, orders, products CASCADE;
-- 1. Find customers who have ordered all products priced above $50 but below $150.
-- Task: Write a query to identify customers who have ordered all products that have a price between $50 and $150.

SELECT customer_id FROM orders WHERE product_id IN (
		SELECT product_id FROM products WHERE price >= 50 AND price <= 150
	)
	GROUP BY customer_id HAVING COUNT(DISTINCT product_id) = (
			SELECT COUNT(DISTINCT product_id) FROM products WHERE price >= 50 AND price <= 150
		)


-- Create a trigger that automatically calculates and updates the total value of the order when a new order is inserted, based on the quantity of the
-- product ordered and the price of the product.

ALTER TABLE orders ADD COLUMN total_value NUMERIC(10, 2);
SELECT * FROM Orders;

CREATE OR REPLACE FUNCTION update_quant()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
	total_quant orders.total_value%type;
BEGIN

	-- SELECT (NEW.quantity * price) INTO total_quant FROM products WHERE product_id = NEW.product_id;
	-- UPDATE orders SET total_value = total_quant WHERE order_id = NEW.order_id;

	SELECT (NEW.quantity * price) INTO NEW.total_value FROM products 
	WHERE product_id = NEW.product_id;
	
	RETURN NEW;
	
END; $$


CREATE OR REPLACE TRIGGER update_value_trig
BEFORE INSERT
ON orders
FOR EACH ROW 
	EXECUTE FUNCTION update_quant();

SELECT * FROM orders;

INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES
(6, 1, 1, 2, '2024-01-10');


-- 3. Create a view that lists the names of customers who have ordered at least one product with a price greater than $100.
-- Task: Create a view that selects the customer_name of customers who have ordered at least one product with a price above $100.

CREATE OR REPLACE VIEW cust AS SELECT customer_name FROM customers WHERE customer_id IN (
	SELECT customer_id FROM orders WHERE product_id IN (
			SELECT product_id FROM products WHERE price > 100
		)
	GROUP BY customer_id HAVING COUNT(DISTINCT product_id) >= 1
)


-- 4. Create an index on the order_date column of the orders table to improve query performance.
-- Task: Create an index on the order_date column of the orders table to optimize queries filtering by order_date.

CREATE INDEX index_order_date ON orders(order_date);


-- 5. Create a stored procedure that returns all products with a price greater than a specified value.
-- Task: Write a stored procedure that accepts a min_price parameter and returns all products with a price greater than the given value.

CREATE OR REPLACE PROCEDURE list_prod(min_price products.price%type)
LANGUAGE PLPGSQL
AS $$
DECLARE
	prod_name products.product_name%type;
	prod_price products.price%type;
	prod_cursor CURSOR FOR SELECT product_name, price FROM products WHERE price > min_price;
BEGIN	

	OPEN prod_cursor;
	RAISE NOTICE 'Name    : Price';
	LOOP 
		FETCH prod_cursor INTO prod_name, prod_price;
		IF NOT FOUND THEN
			EXIT;
		END IF;

		RAISE NOTICE '% : %', prod_name, prod_price;
	END LOOP;
	CLOSE prod_cursor;	
END; $$

CALL list_prod(30.00);

SELECT * FROM products;


-- 6. Create a function that calculates the total price for a specific order (quantity * price).
-- Task: Write a function that takes an order_id as input and returns the total price (quantity * price) for that specific order.

CREATE OR REPLACE FUNCTION get_total_value(id orders.order_id%type)
RETURNS products.price%type
LANGUAGE PLPGSQL
AS $$
DECLARE
	total_val products.price%type;
BEGIN
	SELECT (price * quantity) INTO total_val FROM orders JOIN products ON products.product_id = orders.product_id 
	WHERE order_id = id;

	RETURN total_val;
END; $$

SELECT get_total_value(1);



-- 7. Create a PL/SQL block to update a customer’s name in the customers table based on customer_id and handle errors if the customer_id doesn’t exist.
-- Task: Write a PL/SQL anonymous block to update the customer_name in the customers table for a given customer_id. If the customer_id is not found, raise an exception.

DO $$
DECLARE
	cust_id customers.customer_id%type = 1;
	check_exist bool;
BEGIN
	SELECT 1 INTO check_exist FROM customers WHERE customer_id = cust_id;
	IF check_exist != 1 THEN
		RAISE EXCEPTION '% Not found in customers', cust_id;
	END IF;

	UPDATE customers SET customer_name = 'John Smith' WHERE customer_id = cust_id;
	
END; $$

SELECT * FROM customers;

-- 8. Create a cursor that loops through the orders table and prints the order_id and quantity for each order.
-- Task: Write a cursor that loops through the orders table and prints the order_id and quantity for each order. Use DBMS_OUTPUT.PUT_LINE to display the results.

CREATE OR REPLACE PROCEDURE get_orders()
LANGUAGE PLPGSQL
AS $$
DECLARE
	order_cur CURSOR FOR SELECT order_id, quantity FROM orders;
	id orders.order_id%type;
	quant orders.quantity%type;
BEGIN

	OPEN order_cur;
	LOOP 
		FETCH order_cur INTO id, quant;
		IF NOT FOUND THEN
			EXIT;
		END IF;

		RAISE NOTICE '% : %', id, quant;
	END LOOP;
	CLOSE order_cur;
END; $$

CALL get_orders();

-- 9. Create a view that shows the total quantity of each product ordered, along with the product name.
-- Task: Create a view that displays the total quantity of each product ordered by joining the orders and products tables.

CREATE OR REPLACE VIEW name_quant AS SELECT product_name, SUM(quantity) FROM orders JOIN products ON orders.product_id = products.product_id
GROUP BY product_name;

SELECT * FROM name_quant;

-- 10. Create a block of PL/SQL code to delete orders older than a specific date (e.g., '2023-01-01') and display a message for each deleted order.
-- Task: Write a PL/SQL block to delete orders from the orders table that are older than '2023-01-01'. For each deleted order, print a message stating that the order was deleted.

DO $$
DECLARE
	or_date orders.order_date%type = '2024-02-01';
BEGIN
	DELETE FROM orders WHERE order_date < or_date;
END; $$


SELECT * FROM Orders;


