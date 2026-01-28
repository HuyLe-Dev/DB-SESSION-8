-- 1. Tạo bảng đơn hàng
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    total_amount DECIMAL(15, 0) -- Lưu số tiền (không cần số lẻ cho tiền Việt)
);

-- 2. Thêm dữ liệu mẫu (Có cả đơn nhỏ và đơn lớn)
INSERT INTO orders (total_amount) VALUES 
(150000),      -- Đơn nhỏ
(6500000),     -- Đơn lớn (> 5 triệu)
(4900000),     -- Đơn suýt lớn
(12000000);    -- Đơn rất lớn

SELECT * FROM orders;


DELIMITER //
  CREATE PROCEDURE sp_check_order_value(
    IN p_amount DECIMAL(15, 0)
  )
BEGIN
  IF p_amount >= 5000000 THEN 
    SELECT 'Don hang gia tri cao' AS Ket_luan;
  ELSE 
    SELECT 'Don hang binh thuong' AS Ket_luan;
  END IF;
END //

DELIMITER ; 

--call procedure binh thuong
CALL sp_check_order_value(2000000);


--call procedure voi bang order
-- Lấy tiền của đơn hàng số 2 bỏ vào biến, rồi gọi Procedure
SET @amount = (SELECT total_amount FROM orders WHERE order_id = 2);
CALL sp_check_order_value(@amount);