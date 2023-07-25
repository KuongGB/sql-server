--03-Distinct.sql
---------------------------------
--trong 1 table thì có 1 cột : chứa nhưng data k bao h trùng
--				PK: primary key: khóa chính
--ý nghĩa: giúp cho không có 1 hàng nào trong table có thể trùng nhau 100%
--1 câu lệnh SELECT luôn cho kết quả là 1 table
-- nếu ta dùng select * (lấy ra tất cả các cột) thì có nghĩa là có cột pk
--		kết quả đó không có trùng nhau 100%
--nhưng: 
--	select cột, cột, cột mà nếu như trong số các cột liệt kê bị thiếu PK
--> rất có thể sẽ xuất hiện hàng trùng nhau 100%
--những hàng giống nhau có tên là tuple/ bộ trùng nhau
--ta có thể loại đi các thằng trùng bằng tứ khóa(keyword) Disctint
--vị trí: đặt ngay sau select
---			select distinct cột, cột cột
--> SELECT Distinct cột PK, cột, cột --khùng
--> SELECT Distinct * --khùng
USE convenienceStoreDB
--1. in ra thông tin các khách hàng
SELECT * FROM Customer
--2. các thành phố mà khách đang ở
SELECT City FROM Customer
--xoá trùng
SELECT Distinct City FROM Customer
--3. thông tin các gói hàng đã nhập vào kho
SELECT * FROM InputBill
--4. các sản phẩm đã nhập
SELECT distinct ProID FROM InputBill