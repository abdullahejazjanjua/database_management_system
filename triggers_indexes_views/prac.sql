-- Trigger func
-- CREATE OR REPLACE FUNCTION func_name() --> Takes no arguments
--  RETURNS TRIGGER
-- LANGUAGE plpqsql
-- AS
-- $$
    -- DECLARE
        -- variables
    -- BEGIN
        -- logic
    -- RETURN NEW
-- END $$;

-- CREATE TRIGGER trigger_name
-- BEFORE/AFTER INSERT/UPDATE/DELETE
-- ON table_name
-- FOR EACH ROW/STATEMENT
-- EXECUTE PROCEDURE func_name


-- Views
-- CREATE view view_name AS sql_query
-- ALTER VIEW old_view_name RENAME TO new_view_name
-- DROP VIEW view_name

CREATE OR REPLACE FUNCTION log_update()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
    DECLARE
        time_stamp TIMESTAMP := '2020-01-01 00:00:00';
    BEGIN
        INSERT INTO AuditLog(order_id, action, changed_at) VALUES
        (OLD.order_id, 'Updated value', time_stamp);

        RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER log_update_trig
BEFORE UPDATE
ON Orders
FOR EACH ROW
    EXECUTE FUNCTION log_update();

UPDATE Orders SET quantity = 10 WHERE order_id = 1;
SELECT * FROM Orders;
SELECT * FROM AuditLog;


-- Tasks
-- Q1. Create a BEFORE DELETE trigger on the Orders table that automatically inserts a row into the AuditLog 
-- table every time an order is deleted. The log should include the deleted order’s ID, the action type ('DELETE'), 
-- and the current timestamp.

CREATE OR REPLACE FUNCTION log_delete()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
    DECLARE
    BEGIN
        INSERT INTO AuditLog(order_id, action) VALUES
        (OLD.order_id, 'DELETE');

    RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER log_del
BEFORE DELETE
ON Orders
FOR EACH ROW
    EXECUTE FUNCTION log_delete();

DELETE FROM Orders WHERE order_id = 1;
SELECT * FROM AuditLog;

-- Q2. Create a view named CustomerOrderSummary that displays
CREATE VIEW CustomerOrderSummary AS 
    SELECT Customers.name, Customers.email, COUNT(Orders.order_id) AS Total_orders, SUM(Orders.Quantity) AS Total_Qty
    FROM Orders
    JOIN Customers ON Orders.customer_id = Customers.customer_id 
    GROUP BY Customers.customer_id;

SELECT * FROM CustomerOrderSummary;

-- Indexes
CREATE INDEX index_name ON Products(name);

EXPLAIN ANALYSE SELECT * FROM Products WHERE name LIKE '%a%'

DROP INDEX index_name;