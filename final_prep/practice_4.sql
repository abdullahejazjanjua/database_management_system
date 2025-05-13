-- Total Spending Per Customer
-- Write a query to find the total amount spent by each customer. Return customer_id and total_spent.

SELECT customer_id, SUM(amount) FROM transactions GROUP BY customer_id;

-- 2. Customers Who Spent More Than the Average
-- Write a query to find the customer_id of customers whose total spending exceeds the average spending of all customers.

SELECT customer_id FROM transactions GROUP BY customer_id HAVING SUM(amount) > (
	SELECT AVG(amount) FROM transactions
)


-- 3. Customers Who Made Multiple Transactions
-- Write a query to find the customer_id of customers who have made more than one transaction.

SELECT customer_id FROM transactions GROUP BY customer_id HAVING COUNT(*) > 1;

-- 4. Transactions Above the Customer's Average
-- Write a query to find all transactions where the amount is greater than the average amount spent by that customer.

SELECT * FROM transactions AS T1 WHERE T1.amount > (
	SELECT AVG(T2.amount) FROM transactions AS T2 
	WHERE T1.customer_id = T2.customer_id
	GROUP BY T2.customer_id
)

-- 5. Customers Who Spent the Most in a Single Transaction
-- Write a query to find the customer_id and transaction_id of the customer who spent the most in a single transaction.

SELECT customer_id, transaction_id FROM transactions WHERE amount = (
	SELECT MAX(amount) FROM transactions
)

-- 6. Customers Who Made Transactions in the First Half of January
-- Write a query to find the customer_id of customers who made at least one transaction between January 1 and January 15.

SELECT * FROM transactions WHERE transaction_date >= '2025-01-01' AND transaction_date <= '2025-01-15'; 

-- 7. Customers Who Made Transactions in the Second Half of January
-- Write a query to find the customer_id of customers who made at least one transaction between January 16 and January 31.

SELECT customer_id FROM transactions WHERE transaction_date >= '2025-01-16' AND transaction_date <= '2025-01-31'
GROUP BY customer_id HAVING COUNT(transaction_id) >= 1;


-- 8. Transactions with Amount Greater Than the Average of Their Day
-- Write a query to find all transactions where the amount is greater than the average amount of all transactions on that same day.

SELECT * FROM transactions AS T1 WHERE amount >= (
	SELECT AVG(amount) FROM transactions AS T2 
	WHERE T1.transaction_date = T2.transaction_date
	GROUP BY T2.transaction_date 
)


-- 9. Customers Who Made Transactions on Both January 1 and January 15
-- Write a query to find the customer_id of customers who made transactions on both January 1 and January 15.

SELECT customer_id FROM transactions WHERE 
(transaction_date = '2025-01-01' AND transaction_date = '2025-01-15')
GROUP BY customer_id HAVING COUNT(DISTINCT transaction_date) = 2; 


-- 10. Customers Who Made Transactions on Consecutive Days
-- Write a query to find the customer_id of customers who made transactions on two consecutive days.

SELECT DISTINCT T1.customer_id FROM transactions AS T1 
JOIN transactions AS T2 ON T2.customer_id = T1.customer_id 
AND T1.transaction_date = T2.transaction_date - INTERVAL '1 day';




