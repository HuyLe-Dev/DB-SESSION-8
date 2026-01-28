-- 1. Tạo bảng sinh viên
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    gpa DECIMAL(3, 1) -- Điểm trung bình (ví dụ: 8.5, 7.2)
);

-- 2. Thêm dữ liệu mẫu với các mức điểm khác nhau
INSERT INTO students (full_name, gpa) VALUES 
('Nguyễn Văn An', 8.5),   -- Giỏi
('Trần Thị Bình', 7.0),   -- Khá
('Lê Văn Cường', 5.5),    -- Trung bình
('Phạm Minh Đức', 4.2),   -- Yếu
('Hoàng Thị Em', 6.5);    -- Khá 


DELIMITER //
  CREATE PROCEDURE sp_classify_student(
    IN p_gpa DECIMAL(3, 1),
    IN p_full_name VARCHAR(100)
  )
BEGIN
  DECLARE v_classification VARCHAR(20);
  IF p_gpa >= 8,5 THEN
    SET v_classification = "GIOI";
  ELSEIF p_gpa >= 6,5 AND p_gpa < 8 THEN
    SET v_classification = "KHA";
  ELSE 
    SET v_classification = "YEU";
  END IF;

  SELECT p_full_name AS "TEN HOC SINH", v_classification AS "HOC LUC" , p_gpa AS "DIEM SO" ;
END //

DELIMITER ;

CALL sp_classify_student(10, "HUY");

--REMOVE PROCEDURE: 
DROP PROCEDURE sp_classify_student;