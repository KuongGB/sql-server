--ch02-subQuery
   --01-SingleValue.sql
--SELECT...FROM...WHERE....ORDER BY....
--SELECT * | Cột
--FROM table, table, table (join)
--WHERE điều kiện lọc (data)
--1 câu SELECT luôn trả kết quả dưới dạng table
-------------------------
use convenienceStoreDB	
SELECT FirstName FROM Employee WHERE EmpID = 'Emp001'
--Liệt kê danh sách đến từ tp cùng với nhân viên emp004, tính cả emp004
SELECT City FROM Employee WHERE EmpID = 'emp004'
SELECT * FROM Employee WHERE City = (SELECT City FROM Employee WHERE EmpID = 'emp004')
--nested Query | SubQuery(câu select lồng trong câu select)

---------Bài tập---------
--1. In ra những nhân viên ở London 
SELECT * FROM Employee WHERE City = 'London'

--2. In ra những nhân viên cùng quê với Angelina
SELECT * FROM Employee 
		 WHERE Country = (SELECT Country FROM Employee 
						  WHERE FirstName = 'Angelina') AND NOT FirstName = 'Angelina' 

--3. Liệt kê các đơn hàng có ngày yêu cầu giao
SELECT * FROM Orders WHERE RequiredDate is not NULL 

--4. Liệt kê các đơn hàng có trọng lượng lớn hơn trọng lượng của
--đơn hàng có mã số ORD021
SELECT * FROM Orders 
		 WHERE Freight > (SELECT Freight FROM Orders 
						  WHERE OrdID = 'ORD021')

--5. Liệt kê các đơn hàng trọng lượng lớn hơn đơn hàng ORD021
--và vận chuyển đến cùng tp với đơn hàng mã ORD012, tính cả đơn ORD012
SELECT * FROM Orders 
		 WHERE Freight > (SELECT Freight FROM Orders 
						  WHERE OrdID = 'ORD021') AND ShipCity = (SELECT ShipCity FROM Orders 
																  WHERE OrdID = 'ORD012')

--6. Liệt kê các đơn hàng đc ship cùng tp với đơn hàng ORD014
--và có trọng lượng > 50 pound
SELECT * FROM Orders 
		 WHERE Freight > 50 AND ShipCity = (SELECT ShipCity FROM Orders 
											 WHERE OrdID = 'ORD014')

--7. Những đơn hàng nào đc vận chuyển bởi cty vận chuyển mã số 
--là SHIP003  và được ship đến cùng thành phố với đơn hàng ORD012(ShipVia)
SELECT * FROM Orders 
		 WHERE ShipID = 'SHIP003' AND ShipCity = (SELECT ShipCity FROM Orders 
												   WHERE OrdID = 'ORD012') 

--8. Hãng Giaohangtietkiem vận chuyển những đơn hàng nào
SELECT * FROM Orders
		 WHERE ShipID = (SELECT ShipID FROM Shipper 
						 WHERE CompanyName = 'Giaohangtietkiem')

--9. Liệt kê danh sách các mặt hàng/món hàng/products gồm mã sp
--tên sp, chủng loại (category)
SELECT * FROM Category
SELECT ProID, ProName, CategoryID FROM Product

--10. pork shank thuộc nhóm hàng nào 
--output: mã nhóm, tên nhóm (xuất hiện ở table Category)
SELECT * FROM Category
		 WHERE CategoryID = (SELECT CategoryID FROM Product
							 WHERE ProName = 'pork shank')

--11. Liệt kê danh sách các món hàng có cùng chủng loại với mặt hàng pork shank
--có tính pork shank
SELECT * FROM Product 
		 WHERE CategoryID = (SELECT CategoryID FROM Product
							 WHERE ProName = 'pork shank')

--12.liệt kê các sản phầm có chủng loại là thịt
SELECT * FROM Product 
	     WHERE CategoryID = (SELECT CategoryID FROM Category 
							 WHERE CategoryName = 'meat')

--13-liệt kê ID các nhà cung cấp , cung cấp sản phẩm có tên là pork shank
SELECT * FROM Supplier WHERE SupID in (
SELECT SupID FROM InputBill 
			 WHERE ProID = (SELECT ProID FROM Product 
							WHERE ProName = 'pork shank'))
