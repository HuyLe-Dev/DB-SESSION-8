-- 1. Tạo bảng nhân viên
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(15, 2),    -- Cột nhạy cảm
    id_card_number VARCHAR(20) -- Cột nhạy cảm
);

-- 2. Thêm dữ liệu mẫu (Giả lập lương và CMND thật)
INSERT INTO employees (employee_id, full_name, department, salary, id_card_number) VALUES
(1, 'Nguyễn Văn An', 'IT', 25000000, '001090000001'),
(2, 'Trần Thị Bích', 'HR', 18000000, '001090000002'),
(3, 'Lê Hoàng Cường', 'Sales', 20000000, '001090000003'),
(4, 'Phạm Minh Duy', 'IT', 30000000, '001090000004');

DELIMITER //
CREATE PROCEDURE sp_get_avg_salary()

BEGIN 
  DECLARE v_avg_salary DECIMAL(15, 2);
  SELECT AVG(salary)
  FROM employees
END //
DELIMITER ;