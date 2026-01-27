CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT, -- Mã sinh viên
    full_name VARCHAR(100) NOT NULL,           -- Họ tên
    class_name VARCHAR(50) NOT NULL            -- Lớp học
);

-- Thêm dữ liệu mẫu vào bảng students
INSERT INTO students (full_name, class_name) VALUES
('Nguyễn Văn A', 'K21THCB1'),
('Trần Thị B', 'K21THCB1'),
('Lê Hoàng C', 'K21PTDL2'),
('Phạm Thu D', 'K22PMCL1'),
('Võ Minh E', 'K22PMCL1');

SELECT * FROM students;


DELIMITER //

CREATE PROCEDURE sp_get_all_students()
BEGIN
  SELECT 
        student_id,
        full_name,
        class_name
  FROM
        students;
END //

DELIMITER ;


CALL sp_get_all_students();