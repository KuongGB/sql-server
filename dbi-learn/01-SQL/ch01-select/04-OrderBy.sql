--04-OrderBy.sql

--------------------------------
--SELECT luôn trả về ket qua ở dạng bảng
--ta có thể xếp lại các dòng theo 1(nhiều) cột nào đó
--việc này k ảnh hưởng đến data
--chỉ làm đẹp hơn
--Quy tắc sắp xếp
--     số : so sánh bth
--	   chuỗi: chuỗi dài hơn không có nghĩa là lớn hơn
--			so sánh từ trái sang phải
--			so sánh theo ASCII
--			Không quan tâm hoa thường
--		so sánh sẽ phức tạp hơn nếu so sánh nhiều cột
--			không quan tâm thứ tự(luôn từ trái sang phải)
--			sắp xếp xong, trùng thì qua cột tiếp
--			data trùng thì sắp xếp dựa trên cột tiếp theo
--sắp xếp Điểm giảm dần, Tên tăng dần
-- STT    TÊN  Điểm
-- 001    ABC  9
-- 003    ABC  8
-- 002    ADC  7
-- 004    AEC  10
USE convenienceStoreDB
--1. in ra thông tin các đơn hàng
SELECT * FROM Orders
--2. list các đơn hàng đc xếp theo trọng lượng
--tăng = ascending = ASC
SELECT * FROM Orders order by Freight ASC
--giảm = descending = DESC
SELECT * FROM Orders order by Freight DESC
--3. tên nhân viên
--tăng 
SELECT FirstName + ' ' + LastName as fullName FROM Employee ORDER BY fullName ASC
--giảm
SELECT FirstName + ' ' + LastName as fullName FROM Employee ORDER BY fullName DESC
--4. đơn hàng tăng dần theo mã nhân viên chịu  trách nhiệm cho đơn hàng
--và giảm dần theo cân nặng
SELECT * FROM Orders order by EmpID ASC, Freight DESC	