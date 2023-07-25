--02-MultipleValue.sql
--Multiple là câu SELECT trả ra kết quả 1 hàng 1 cột| 1 cell
--Hoặc trả ra hơn 1 cell
use convenienceStoreDB
---------------------------------------------------------
--1. Liệt kê các sản phẩm thuộc nhóm hàng CATE006, CATE005, CATE003
SELECT * FROM Product WHERE CategoryID in ('CATE006', 'CATE005', 'CATE003')
--2. Liệt kê các sản phẩm thuộc nhóm hàng thịt, ô tô, bag
SELECT * FROM Product 
WHERE CategoryID in (SELECT CategoryID FROM Category 
					 WHERE CategoryName in ('meat', 'car', 'bag'))
--3. in ra danh sách id của các nhà cung cấp cung cấp những mặt hàng có chũng loại là 
--car, meat, bag - inputBill (thông tin xuất nhập kho)
SELECT SupID FROM InputBill 
WHERE ProID in (SELECT ProID FROM Product
				WHERE CategoryID in (SELECT CategoryID FROM Category 
									 WHERE CategoryName in ('meat', 'car', 'bag')))
		-- in ra thông tin các nhà cung cấp đã cung cấp những mặt hàng có chủng loại là car, meat, bag --3
SELECT * FROM Supplier 
WHERE SupID in (SELECT SupID FROM InputBill 
				WHERE ProID in (SELECT ProID FROM Product 
								WHERE CategoryID in (SELECT CategoryID FROM Category 
													 WHERE CategoryName in ('meat', 'car', 'bag'))))
--4. Đơn hàng nào bán cho khách hàng đến từ việt nam,  Mĩ , Nhật 
SELECT * FROM Orders 
WHERE CustomerID in (SELECT CusID FROM Customer 
					 WHERE Country in ('Vietnam', 'USA', 'Japan'))
--5. Đơn hàng nào bán cho khách hàng đến từ việt nam,  Mĩ , Nhật 
--và ship đến cùng thành phố
--với đơn hàng ORD015, tính luôn ORD015
SELECT * FROM Orders 
WHERE CustomerID in (SELECT CusID FROM Customer
					  WHERE Country in ('Vietnam', 'USA', 'Japan') 
						AND ShipCity = (SELECT ShipCity FROM Orders 
										WHERE OrdID = 'ORD015'))
--6. Đơn hàng nào bán cho khách hàng KHÔNG đến từ mĩ, Nhật
--NOT có thể xài ở 1 trong 2 CHỖ IN
SELECT * FROM Orders 
WHERE not CustomerID in (SELECT CusID FROM Customer 
						 WHERE Country IN ('USA', 'Japan'))
--7. Nhân viên mã số EMP004 phụ trách những đơn hàng nào 
SELECT * FROM Orders WHERE EmpID = 'EMP004'
--8. Nhân viên quê ở NY phụ trách những đơn hàng nào
SELECT * FROM Orders 
WHERE EmpID in (SELECT EmpID FROM  Employee 
				WHERE City = 'NY')
--9. các đơn hàng được gữi tới london , bởi các nhà vận chuyển nào 
SELECT * FROM Shipper 
WHERE ShipID in (SELECT ShipID FROM Orders 
				 WHERE ShipCity = 'London')
--10. Nhân viên nào phụ trách các đơn hàng gữi tới NY
SELECT * FROM Employee 
WHERE EmpID in (SELECT EmpID FROM Orders 
				WHERE ShipCity = 'NY')
--11. Nhà cung cấp SUP003 và SUP005 cung cấp những sản phẩm nào
SELECT * FROM Product 
WHERE ProID in (SELECT ProID FROM InputBill 
				WHERE SupID in ('SUP003', 'SUP005'))

--12. các nhà cung cấp không đến từ việt nam cung cấp những sản phẩm có chủng loại gì ?
SELECT * FROM Category 
WHERE CategoryID in (SELECT CategoryID FROM Product 
					 WHERE ProID in (SELECT ProID FROM InputBill 
									 WHERE SupID in (SELECT SupID FROM Supplier 
													 WHERE Country != 'Viet Nam')))
				SELECT * FROM Supplier
--13. Nhân viên Enno's chăm sóc những đơn hàng nào
SELECT * FROM Orders WHERE EmpID in (SELECT EmpID FROM Employee WHERE FirstName = 'Enno''s')
SELECT * FROM Employee