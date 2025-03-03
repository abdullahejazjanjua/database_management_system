CREATE TABLE products(
    product_no INT,
    description TEXT,
    cost NUMERIC
);

ALTER TABLE products ADD PRIMARY KEY(product_no); -- Makes product_no PK
ALTER TABLE products DROP CONSTRAINT products_pkey; -- Removes the PK constraint


-- ON DELETE CASCADE: deletes the both entry in the primary table and reference in foreign table
-- ON UPDATE CASCADE: Changing id in primary table also changes same id of reference in foriegn table

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    category_id INT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_categories FOREIGN KEY(category_id) REFERENCES categories(category_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE product;

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Home Appliances'),
('Books'),
('Toys');

INSERT INTO product (category_id, product_name, price) VALUES
(1, 'Laptop', 999.99),
(1, 'Smartphone', 799.99),
(2, 'T-Shirt', 19.99),
(2, 'Jeans', 49.99),
(3, 'Microwave', 150.00),
(3, 'Vacuum Cleaner', 200.00),
(4, 'Fiction Book', 12.99),
(4, 'Science Book', 24.99),
(5, 'Action Figure', 29.99),
(5, 'Board Game', 39.99);

SELECT * FROM categories;
SELECT * FROM product;

DELETE FROM categories WHERE category_id = 1; -- This will delete entry in category table and also from products table
UPDATE categories SET category_id = 100 WHERE category_name = 'Clothing'; -- This will update category id from 2 to 100 in both tables 

-- Unique: ALTER TABLE table_name ADD CONSTRAINT constraint_name UNIQUE(column_name); 
-- Not Null: ALTER TABLE table_name ALTER COLUMN column_name SET NOT NULL;
-- Check: ALTER TABLE table_name ADD CONSTRAINT constraint_name CHECK (condition);
-- Foreign Key: ALTER TABLE table_name ADD CONSTRAINT constraint_name FOREIGN KEY (column_name) REFERENCES other_table(other_column);
-- Primary Key: ALTER TABLE table_name ADD CONSTRAINT constraint_name PRIMARY KEY (column_name);
-- Drop Constraint: ALTER TABLE table_name DROP CONSTRAINT constraint_name;