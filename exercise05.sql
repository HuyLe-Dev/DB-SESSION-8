-- 1. Tạo bảng nhân viên
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(15, 0)
);

-- 2. Thêm dữ liệu với đủ các mức thu nhập để test
INSERT INTO employees (full_name, department, salary) VALUES 
('Nguyễn Văn A', 'IT', 25000000),  -- Thu nhập cao
('Trần Thị B', 'HR', 12000000),    -- Thu nhập trung bình
('Lê Văn C', 'Sale', 6000000),     -- Thu nhập thấp
('Phạm Thu D', 'Admin', 8000000);  -- Ngay mép Thu nhập trung bình


DELIMITER //
CREATE PROCEDURE sp_check_employee_income(
  IN p_full_name VARCHAR(100),
  IN P_salary DECIMAL(15, 0)
)
BEGIN
  IF p_salary >= 15000000 THEN
    SELECT "Thu nhập cao" AS Ket_luan, p_full_name AS HO_TEN;
  ELSEIF p_salary >= 8000000  AND p_salary < 15000000 THEN
    SELECT "Thu nhập trung bình" AS Ket_luan, p_full_name AS HO_TEN;
  ELSE
    SELECT "Thu nhập thấp" AS Ket_luan, p_full_name AS HO_TEN;
  END IF;
END //

DELIMITER ;

--Kiem tra khong lien quan den bang
CALL sp_check_employee_income('Nguyen Van A', 5000000);

--Kiem tra co lien quan den bang

-- Lấy dữ liệu của nhân viên ID = 2 ra biến
SELECT full_name, salary INTO @ten, @luong 
FROM employees WHERE employee_id = 2;

-- Truyền biến vào Procedure
CALL sp_check_employee_income(@ten, @luong);