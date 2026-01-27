CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(50) NOT NULL -- Loại sản phẩm
);

-- Thêm dữ liệu mẫu vào bảng products
INSERT INTO products (product_name, price, category) VALUES
('iPhone 13', 20000000, 'Điện thoại'),
('Samsung Galaxy S21', 15000000, 'Điện thoại'),
('Macbook Air M1', 25000000, 'Laptop'),
('Dell XPS 15', 30000000, 'Laptop'),
('Sony WH-1000XM4', 7000000, 'Tai nghe'),
('AirPods Pro 2', 6000000, 'Tai nghe');

SELECT * FROM products;


DELIMITER //

CREATE PROCEDURE sp_get_products_by_category (
  IN p_category VARCHAR(50)
)

BEGIN
      
      SELECT 
        product_id,
        product_name,
        price,
        category
      FROM products
      WHERE category = p_category;
END //

DELIMITER ;

CALL sp_get_products_by_category('Điện thoại');