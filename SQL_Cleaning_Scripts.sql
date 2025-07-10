-- Orders Table

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    region VARCHAR(50)
);



-- OrderItems Table

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price NUMERIC(10,2),
    discount NUMERIC(3,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);



-- Customers Table

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    join_date DATE,
    segment VARCHAR(50)
);



-- Products Table

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);



-- Returns Table

CREATE TABLE returns (
    return_id SERIAL PRIMARY KEY,
    order_id INT,
    return_date DATE,
    return_reason VARCHAR(100)
);




-- Customers

INSERT INTO customers VALUES
(101, 'Aarav Mehta', '2023-01-10', 'Consumer'),
(102, 'Meera Singh', '2023-02-12', 'Corporate'),
(103, 'Rahul Verma', '2023-03-05', 'Home Office'),
(104, 'Sneha Nair', '2023-04-18', 'Consumer');



-- Orders

INSERT INTO orders VALUES
(1001, '2023-06-01', 101, 'North'),
(1002, '2023-06-03', 102, 'South'),
(1003, '2023-06-05', 103, 'East'),
(1004, '2023-06-07', 104, 'West'),
(1005, '2023-06-09', 101, 'North');



-- Products

INSERT INTO products VALUES
(201, 'Lenovo Laptop', 'Electronics', 'Computers'),
(202, 'Office Chair', 'Furniture', 'Chairs'),
(203, 'LED Monitor', 'Electronics', 'Monitors'),
(204, 'Whiteboard', 'Office Supplies', 'Stationery'),
(205, 'Wireless Mouse', 'Electronics', 'Accessories');



-- OrderItems

INSERT INTO order_items VALUES
(1, 1001, 201, 2, 50000, 0.10),
(2, 1001, 205, 1, 1500, 0.05),
(3, 1002, 202, 3, 7000, 0.00),
(4, 1003, 203, 1, 12000, 0.15),
(5, 1004, 204, 2, 1000, 0.05),
(6, 1005, 205, 0, 1500, 0.10),  -- Zero quantity (should be removed)
(7, 1005, 203, 1, -10000, 0.10); -- Negative price (should be removed)



-- Returns

INSERT INTO returns (order_id, return_date, return_reason) VALUES
(1003, '2023-06-10', 'Damaged'),
(1004, '2023-06-12', 'Wrong item');




SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM returns;




SELECT 
      o.order_id,
      o.order_date,
	  o.region,
	  c.customer_id,
	  c.segment,
	  p.category,
	  p.sub_category,
	  oi.quantity,
	  oi.unit_price,
	  oi.discount,
	  (oi.quantity * oi.unit_price * (1- oi.discount)) as Net_Revenue,
	  (oi.quantity * oi.unit_price * (1- oi.discount))
	  -  (oi.quantity * oi.unit_price * (0.70)) as Profit,
	  CASE
	      WHEN r.order_id is not null THEN 'yes'
          ELSE 'No'
    END AS return_flag
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON  o.customer_id = c.customer_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN returns r ON o.order_id = r.order_id
WHERE
    oi.quantity > 0
    AND oi.unit_price >= 0;






















