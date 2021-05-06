

CREATE TABLE products_log(
	User VARCHAR(255),
	product_id INT,
	product_name VARCHAR(255),
	price DECIMAL(15,2),
	quantity_on_hand INT,
	new_quantity_on_hand INT,
	log_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

SELECT USER();

/*
The purpose of this trigger is to keep a log everytime someone updates the product table quantity_on_hand. This 
could be due to incoming shipments, returns, or exchanges. Overall, this trigger will update the table products_log
when the quantity_on_hand changes.
*/

DELIMITER $$
CREATE TRIGGER products_after_update
	AFTER UPDATE ON products
	FOR EACH ROW 
BEGIN 
	
	INSERT INTO products_log
	(user, product_id, product_name, price, quantity_on_hand, new_quantity_on_hand)
	VALUES
	(USER(), OLD.product_id, OLD.product_name, OLD.price, OLD.quantity_on_hand, NEW.quantity_on_hand);

END$$
DELIMITER ;

SELECT *
FROM products 
ORDER BY RAND()
LIMIT 1;

UPDATE products 
SET quantity_on_hand = 555
WHERE product_id = 30
	AND quantity_on_hand = 590;
	
SELECT * 
FROM products_log;