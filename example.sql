-- Thay đổi DELIMITER để có thể tạo Stored Procedure với dấu chấm phẩy bên trong
DELIMITER //

-- Bảng sản phẩm
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    stock_quantity INT, -- Số lượng tồn kho
    price DECIMAL(10, 2)
);

-- Bảng đơn hàng
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20) DEFAULT 'Pending'
);

-- Bảng chi tiết đơn hàng (các sản phẩm trong một đơn hàng)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    item_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Thêm dữ liệu mẫu
INSERT INTO products (product_id, product_name, stock_quantity, price) VALUES
(1, 'Áo thun', 100, 150000),
(2, 'Quần jean', 50, 300000),
(3, 'Giày thể thao', 75, 500000);

-- Reset DELIMITER về mặc định
DELIMITER ;



DELIMITER //

CREATE PROCEDURE CreateNewOrder (
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_order_id INT;
    DECLARE v_product_price DECIMAL(10, 2);
    DECLARE v_total_amount DECIMAL(10, 2);
    DECLARE v_current_stock INT;

    -- Kiểm tra số lượng tồn kho trước khi tạo đơn
    SELECT stock_quantity, price INTO v_current_stock, v_product_price
    FROM products
    WHERE product_id = p_product_id;

    IF v_current_stock >= p_quantity THEN
        -- Bước 1: Tạo đơn hàng chính
        SET v_total_amount = p_quantity * v_product_price;
        INSERT INTO orders (customer_id, order_date, total_amount, status)
        VALUES (p_customer_id, CURDATE(), v_total_amount, 'Confirmed');

        -- Lấy ID của đơn hàng vừa tạo để dùng cho chi tiết đơn
        SET v_order_id = LAST_INSERT_ID();

        -- Bước 2: Thêm chi tiết sản phẩm vào đơn hàng
        INSERT INTO order_items (order_id, product_id, quantity, item_price)
        VALUES (v_order_id, p_product_id, p_quantity, v_product_price);

        -- Bước 3: Cập nhật số lượng tồn kho
        UPDATE products
        SET stock_quantity = stock_quantity - p_quantity
        WHERE product_id = p_product_id;

        SELECT 'Đơn hàng đã được tạo thành công!', v_order_id AS new_order_id;
    ELSE
        SELECT 'Lỗi: Số lượng sản phẩm không đủ trong kho!';
    END IF;
END //

DELIMITER ;


CALL CreateNewOrder(101, 1, 2); -- Khách 101 mua sản phẩm 1 với số lượng 2

CALL CreateNewOrder(102, 2, 100); -- Khách 102 mua sản phẩm 2 với số lượng 100 (vượt quá tồn kho)