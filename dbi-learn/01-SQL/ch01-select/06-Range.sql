﻿--06-Range

--I.Lý Thuyết
--1. khi ta cần lọc hay filter /(where) các 
--dòng nào đó trong 1 table và dk
--mà ta muốn lọc 1 đoạn (from... to....)
-- [1990 - 2000]--> year >= 1990 and year <= 2000
--liệt kê ra 1 tập hợp: 1 2 4 6 7 8 9
--DBE cung cấp cho mình 2 toán tử là Between và in
--between dùng cho đoạn, khoản
--in dùng cho tập hợp

--vd:[1990 - 2000]--> year between 1990 and 2000
				--> year >= 1990 and year <= 2000

--vd2: lấy ra các bạn sinh năm 1990 1997 1999
			--> year in (1990, 1997, 1999)
			--> year = 1990 or year = 1997 or year = 1999
--II-Thực Hành
use convenienceStoreDB
--1. Liệt kê các đơn hàng gửi tới Anh Mĩ Nhật (337)a
  SELECT * FROM Orders where ShipCountry in ('UK', 'USA', 'Japan')
--2. Liệt kê các Nhân Viên không ở thành phố London và NY
	SELECT * FROM Employee where not City in ('London','NY')
--viết 3 cách not(2), in, bth
	SELECT * FROM Employee where not (City = 'London' or City = 'NY')
	SELECT * FROM Employee where City != 'London' or City != 'NY'
--3. Liệt kê các đơn hàng có trọng lượng từ 50 đến 100 pound
-- filter 1 đoạn, ta xài < and >, between (173)
	SELECT * FROM Orders where Freight between 50 and 100
	SELECT * FROM Orders where Freight >= 50 and Freight <= 100
-- ko xài between, còn cách khác, dùng not 
	SELECT * FROM Orders where not (Freight > 500 AND Freight < 100)
--between là đẹp nhất


--4. Liệt kê các đơn hàng trong năm 2021 ngoại trừ các tháng 6 7 8 9 
--làm bằng 2 cách
	SELECT * FROM Orders Where YEAR(ShippedDate) = 2021 and not MONTH(ShippedDate) between 6 and 9
