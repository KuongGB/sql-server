--04-All.sql
--Tạo ngôi nhà (database) : create database
CREATE DATABASE DBK17F2_SubQuery_ALL
USE DBK17F2_SubQuery_ALL

--tạo table lưu 1 vài số nguyên lẽ: Create table
----->DML : data manipulation language
		--(Insert | SELECT | DELETE | UPDATE)
----->DCL : data control language
		--(REVOKE | GRANT)
----->DDL : data definition language
		--(CREATE | ALTER | DROP | UPDATE)
CREATE TABLE Odds(
	Number int --tạo cột tên Number kiểu integer (số nguyên)
)
SELECT * FROM Odds
---
INSERT INTO Odds VALUES (1)
INSERT INTO Odds VALUES (3)
INSERT INTO Odds VALUES (5)
INSERT INTO Odds VALUES (7)
INSERT INTO Odds VALUES (9)
--DROP: bỏ cái tủ| DELETE: Xoá bên trong cái tủ
--DELETE Odds
--Tạo table lưu vài số chẵn
CREATE TABLE Evens(
	Number INT
)
--==--==--==--
INSERT INTO Evens VALUES (0)
INSERT INTO Evens VALUES (2)
INSERT INTO Evens VALUES (4)
INSERT INTO Evens VALUES (6)
INSERT INTO Evens VALUES (8)
--==--==--==--
SELECT * FROM Evens

---Tạo table lưu trữ các số nguyên
CREATE TABLE Ints(
	Number INT
)

INSERT INTO Ints VALUES (0)
INSERT INTO Ints VALUES (2)
INSERT INTO Ints VALUES (4)
INSERT INTO Ints VALUES (6)
INSERT INTO Ints VALUES (8)
INSERT INTO Ints VALUES (1)
INSERT INTO Ints VALUES (3)
INSERT INTO Ints VALUES (5)
INSERT INTO Ints VALUES (7)
INSERT INTO Ints VALUES (9)

SELECT * FROM Odds

SELECT * FROM Evens

SELECT * FROM Ints

-----
--1.SQL cung cấp thêm toán tử ALL dùng để kết hợp mệnh đề só sánh
--- > < >= <= = !=

--Cú pháp: WHERE Toán tử so sánh ALL(subQuery MultipleValue | Single)
--Ví dụ:
-- VD1: An có phải là người cao điểm hơn tất cả các bạn đến từ tp HCM hong
-- VD2: Trong nhưng thằng bên nhóm A thằng nào thấp hơn những thằng bên nhóm B

--2.Ý nghĩa 
---Where cột so sánh với ALL (tập hợp)
-- So sánh value của cột với tất cả value trong tập hợp
--Thằng nào thoả điều kiện thì lấy
-----------------------------------------------------
--1. Tìm trong Evens những số lớn hơn những số bên Odds
SELECT * FROM Evens
WHERE Number >ALL (SELECT Number FROM Odds)
--2. Tìm trong Odds những số lớn hơn những số bên Evens
SELECT * FROM Odds
WHERE Number >ALL (SELECT Number FROM Evens)
--3. Tìm trong Odds những số lớn hơn những số bên Odds
SELECT * FROM Odds
WHERE Number >ALL (SELECT Number FROM Odds)
--4. Tìm trong Odds những số lớn hơn or bằng những số bên Odds
SELECT * FROM Odds
WHERE Number >=ALL (SELECT Number FROM Odds)
--tìm số lớn nhất trong bảng Odds
--5. Tìm số bé nhất trong Ints
SELECT * FROM Ints
WHERE Number <=All (SELECT Number FROM Ints)
--
SELECT * FROM Ints
WHERE Number <=All(SELECT Number FROM Ints)

----
USE convenienceStoreDB
--1. In ra thông tin nhân viên kèm tuổi của họ
SELECT *, year(GETDATE()) - YEAR(Birthday) as AGE FROM Employee
--2.In ra thông tin nhân viên lớn tuỏi nhất
SELECT *, year(GETDATE()) - YEAR(Birthday) as AGE FROM Employee 
WHERE year(GETDATE()) - YEAR(Birthday) >=ALL( SELECT year(GETDATE()) - YEAR(Birthday) as AGE FROM Employee)
--3*. Trong các nhân viên ở USA, nhân viên nào có tuổi lớn nhất
insert into Employee values ('Emp014',N'Tuấn',N'Nguyễn',N'Telesale','HCM','49 Võ Văn Tần', 'VietNam',N'1960-01-01')

SELECT *, year(GETDATE()) - YEAR(Birthday) as AGE FROM Employee 
WHERE Country = 'USA' AND year(GETDATE()) - YEAR(Birthday) >=ALL(SELECT year(GETDATE()) - YEAR(Birthday) as AGE FROM Employee 
																 WHERE Country = 'USA')

--4. in ra thông tin của những sản phẩm thuộc chủng loại, quần áo, túi,moto
SELECT * FROM Category 
WHERE CategoryName in ('bag', 'clothes', 'moto')
SELECT * FROM Product 
WHERE CategoryID in (SELECT CategoryID FROM Category 
					 WHERE CategoryName in ('bag', 'clothes', 'moto'))

--5. Đơn hàng nào có trọng lượng lớn nhất???
--PHÂN TÍCH: lấy ra đc tập hợp các trọng lượng đang có 
--sau đó sàng lại trong đám trọng lượng, ai lớn hơn hay bằng tất cả
SELECT * FROM Orders 
WHERE Freight >=ALL(SELECT Freight FROM Orders)
--5.1. Trong tất cả các đơn hàng, trọng lượng lớn nhất là bao nhiêu
SELECT Freight FROM Orders 
WHERE Freight >=ALL(SELECT Freight FROM Orders)

--6. Trong các đơn hàng gửi tới Hàng Mã, Tokyo đơn hàng nào trọng lượng
--lớn nhất (vi diệu)
SELECT * FROM Orders 
WHERE ShipCity in ('Tokyo', N'Hàng mã') AND Freight >=ALL(SELECT Freight FROM Orders 
														  WHERE ShipCity in ('Tokyo', N'Hàng mã'))

--7. Trong các đơn hàng gửi tới Hàng Mã, Tokyo đơn hàng nào trọng lượng
--nhỏ nhất (vi diệu)
SELECT * FROM Orders 
WHERE ShipCity in ('Tokyo', N'Hàng mã') AND Freight <=ALL(SELECT Freight FROM Orders 
														  WHERE ShipCity in ('Tokyo', N'Hàng mã'))

--8. Sản phẩm nào giá bán cao nhất
SELECT * FROM Product 
WHERE Price >=ALL(SELECT Price FROM Product)
--9. Sản phẩm có giá bán cao nhất thuộc chủng loại gì
SELECT * FROM Category 
WHERE CategoryID in (SELECT CategoryID FROM Product 
					 WHERE Price >=ALL(SELECT Price FROM Product))	
