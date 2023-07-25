--03-MultipleColumn
--Caau SELECT luôn trả ra kết quả dưới dạng table
--Mệnh đè SELECT đầy đủ
--SELECT...FROM...WHERE..GROUP BY...HAVING...ORDER BY...
--SELECT * | Cột, Cột
--FROM Table, Table, subQuery
--SELECT mà dùng ở mệnh đề FROM
--cần đáp ứng 2 yêu cầu sau
--1. Table kết quả ko có 'no column name'
--2. table kết quả phải có tên
---> phải đặt tên bằng Alias (as)

--1.Lấy các khách hàng đến từ London
SELECT * FROM Customer
WHERE City = 'London'
--2.Lấy ra khách hàn đến từ London và đã xác định số điện thoại
SELECT * FROM Customer
WHERE City = 'London' AND PhoneNumber is not null
--Biểu diễn--
--Tỏ ra mình ngầu, thượng đẳng
SELECT * FROM (SELECT * FROM Customer
			   WHERE City = 'London') as ld 
			   WHERE PhoneNumber is not null
-----
SELECT * FROM (SELECT * FROM Customer
				WHERE PhoneNumber is not null) as ld
				WHERE city = 'London'

----
SELECT * FROM (SELECT * FROM Customer
			   WHERE City = 'London' AND PhoneNumber is not null) as ld 


--3.Liệt kê các đơn hàng gữi đến London, California, Hàng Mã và 
--được nhân viên EMP001 chịu trách nhiệm --8 
-- 3 cách
	SELECT * FROM Orders WHERE ShipCity in ('London', 'California',N'Hàng Mã') AND EmpID = 'EMP001'
--c2:
	SELECT * FROM (SELECT * FROM Orders WHERE ShipCity in ('London', 'California',N'Hàng Mã') AND EmpID = 'EMP001') as hi
--c3:
	SELECT * FROM (SELECT * FROM Orders WHERE ShipCity in ('London', 'California',N'Hàng Mã')) as hi WHERE EmpID = 'EMP001'
--4.Liệt kê các đơn hàng gữi đến London, California, Hàng Mã và 
--được mua bởi các khách hàng có tên Roney , Hồng--6-- 3 cách
--c1
	SELECT * FROM Orders WHERE ShipCity in ('London', 'California',N'Hàng Mã') AND CustomerID  in (SELECT CusID FROM Customer WHERE FirstName in('Roney', N'Hồng'))
--c2
	SELECT * FROM (	SELECT * FROM Orders WHERE ShipCity in ('London', 'California',N'Hàng Mã') AND CustomerID  in (SELECT CusID FROM Customer WHERE FirstName in('Roney', N'Hồng'))) as hi
--c3
	SELECT * FROM (SELECT * FROM Orders WHERE ShipCity in ('London', 'California',N'Hàng Mã')) as hi WHERE CustomerID  in (SELECT CusID FROM Customer WHERE FirstName in('Roney', N'Hồng')))
----5. liệt kê các đơn nhập của nhà cung cấp bởi SUP006 và
-- có số lượng dưới 1000 -- 3 cách
--c1:
	SELECT * FROM InputBill WHERE SupID = 'SUP006' AND Amount < 1000
--c2:
	SELECT * FROM (SELECT * FROM InputBill WHERE SupID = 'SUP006' AND Amount < 1000) as hi
--c3:
	SELECT * FROM (SELECT * FROM InputBill WHERE SupID = 'SUP006') as hi WHERE Amount < 1000


--5.(hỏi trực tiếp) liệt kê các đơn nhập của nhà cung cấp bởi Vingroup và
-- có số lượng dưới 1000 -- 3 cách
--c1:
	SELECT * FROM InputBill WHERE SupID in (SELECT SupID FROM Supplier WHERE SupName = 'Vingroup') AND Amount < 1000
--c2:
	SELECT * FROM (SELECT * FROM InputBill WHERE SupID in (SELECT SupID FROM Supplier WHERE SupName = 'Vingroup') AND Amount < 1000) as hi
--c3:
	SELECT * FROM (SELECT * FROM InputBill WHERE SupID in (SELECT SupID FROM Supplier WHERE SupName = 'Vingroup')) as hi WHERE Amount < 1000