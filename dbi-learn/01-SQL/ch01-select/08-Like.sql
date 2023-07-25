﻿--08-Like.sql

--so sánh '=' là so sánh chính xác, phải chuẩn 100%
--DBEngine cung cấp cho mình toán tử like
--giúp mình tìm gần giống, giống như google (lấy ra các tỉnh có chữ 'Hà' trong tên 'Hà Nội', 'Hà Giang')
--like đi kèm 2 toán tử đặc biệt % và _
--% là đại diện cho 0 đến nhiều ký tự (cột like 'h%' -> h, hello, habc)
--_ là đại diện cho 1 ký tự (cột like 'h_llo' -> hillo, hello, hollo, hlllo, h llo)
--Vd1: tìm ra sinh viên có tên là Điệp
	--> name = N'Điệp'
--Vd2: Tìm ra sinh viên có chữ Điệp trong tên
	--> name like N'%Điệp%' --> aaĐiệpaa
--Vd3: tìm ra người có tên là chữ Điệp ở đầu
	--> name like N'Điệp%'
--Vd4: tìm ra tên của người có 3 ký tự và có chữ a ở đầu
	--> name like N'A__'

--1. Xài db convenienceStoreDB
use convenienceStoreDB
--2. In ra danh sách nhân viên
select * from Employee
--3. In ra nhân viên có tên là Scarlett
select * from Employee where FirstName = N'Scarlett'
--4. In ra những nhân viên có tên là Hanna
select * from Employee where FirstName = N'Hanna'
--5. In ra những nhân viên mà họ có chữ A đứng đầu
select * from Employee where FirstName like N'a%'
--6. In ra những nhân viên mà họ có chữ A đứng cuối cùng
select * from Employee where LastName like N'%a'
--7. In ra những nhân viên mà tên có chữ A
select * from Employee where FirstName like N'%a%'
--8. Những nhân viên nào có tên gồm đúng 3 ký tự
select * from Employee where FirstName like N'_'
--9. Những nhân viên nào có họ gồm đúng 2 ký tự
select * from Employee where LastName like N'__'
--10. Những nhân viên nào mà tên có đúng 6 ký tự, ký tự cuối cùng là e
--viết 2 cách
select * from Employee where FirstName like N'_____e'
--11. Những nhân viên nào mà tên có 6 ký tự, và có chữ A
select * from Employee where FirstName like N'____' and FirstName like N'%a%'
--12. Tìm các khách hàng mà địa chỉ có I đứng thứ 2 từ bên trái sang
select * from Customer where Address like N'_i%'
--13. Tìm các sản phẩm mà tên sản phẩm có 5 ký tự
select * from Product where ProName like N'___'
--14. Tìm các sản phẩm mà từ cuối cùng trong tên sản phẩm có 5 ký tự
select * from Product where ProName like N'% ___' or ProName like N'___'

--[VinFast Lux A 2.0 là 1 ngoại lệ, nó sẽ phát sinh dưới
--dạng 1 ký tự kèm .]
--Nên khi đặt tên cho cell cần hết sức lưu ý
update Product set ProName = N'VinFast Lux B 2.0' where ProID = 'PRO007'
--1. In ra sản phẩm mà tên của nó có ký tự '.'
select * from Product where ProName like '%.%'
--2. In ra nhân viên mà địa chỉ của nó có ký tự '_'
--C1: phế võ công của _ hoặc % trong like bằng []
select * from Employee where Address like '%[_]%'
--C2: ký tự thoát: escape '# $ ^ ~'
select * from Employee where Address like '%#_%' escape '#'
--3. Tìm kiếm những nhân viên có ' trong tên
select * from Employee where FirstName like '%''%'