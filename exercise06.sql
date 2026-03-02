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
    IN p_avg_score DECIMAL(4, 2), 
    OUT p_rank VARCHAR(20)  
)
BEGIN
    DECLARE v_result VARCHAR(20);

    -- Sử dụng cấu trúc CASE để kiểm tra điều kiện
    CASE
        WHEN p_avg_score >= 8.0 THEN 
            SET v_result = 'Giỏi';
        WHEN p_avg_score >= 6.5 THEN 
            SET v_result = 'Khá';  -- Tự động hiểu là < 8.0 vì đã check ở trên
        WHEN p_avg_score >= 5.0 THEN 
            SET v_result = 'Trung bình'; -- Tự động hiểu là < 6.5
        ELSE 
            SET v_result = 'Yếu';
    END CASE;

    -- Gán kết quả từ biến trung gian vào tham số OUT để trả về
    SET p_rank = v_result;

END //

DELIMITER ;
--TEST
CALL sp_classify_student(8.5, @xeploai);

SELECT @xeploai AS "Kết quả xếp loại"; 

--REMOVE PROCEDURE: 
DROP PROCEDURE sp_classify_student;
