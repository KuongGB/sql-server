--ch04-Join
--01-Join
CREATE DATABASE DBK17F2_Ch04_Join
Use DBK17F2_Ch04_Join

--Tạo table master
CREATE TABLE Master(
	MNO int,
	ViDesc nvarchar(10),
)

--insert data
INSERT INTO Master VALUES(1,N'Một')
INSERT INTO Master VALUES(2,N'Hai')
INSERT INTO Master VALUES(3,N'Ba')
INSERT INTO Master VALUES(4,N'Bốn')
INSERT INTO Master VALUES(5,N'Năm')

SELECT * FROM Master

CREATE TABLE Detailed(
	DNO int,
	EnDesc nvarchar(10),
)

INSERT INTO Detailed VALUES(1,N'One')
INSERT INTO Detailed VALUES(3,N'Three')
INSERT INTO Detailed VALUES(5,N'Five')
INSERT INTO Detailed VALUES(7,N'Seven')

SELECT * FROM Detailed

SELECT * FROM Master, Detailed WHERE MNO = DNO --tích đề cát --Tích Descartes
SELECT * FROM Detailed, Master

---Pro thì ko làm z
SELECT * FROM Master inner join Detailed on MNO = DNO
SELECT * FROM Master join Detailed on MNO = DNO

---Join môn đăng hộ đối
---Join đựa trên điểm trùng
------------------------------
--Outter Join (Join Phần Ngoài)
SELECT * FROM Master left join Detailed on MNO = DNO
---Nhận master làm gốc và kéo sang Detailed tìm phần chung
--nếu ko có thì null
--master giữ full data
SELECT * FROM Master right join Detailed on MNO = DNO
--
SELECT * FROM Master full join Detailed on MNO = DNO
--giữ hết data

CREATE TABLE Major(
	ID char(3) PRIMARY KEY,
	Name nvarchar(30),
	Room char(4),
	Hotline char(11),
)

insert into Major values ('IS','Information System','R101','091x...')
insert into Major values ('JS','Japanese Software Eng','R101','091x...')
insert into Major values ('ES','Embedded System','R102','091x...')
insert into Major values ('JP','Japanese Language','R103','091x...')
insert into Major values ('EN','English','R102',null)
insert into Major values ('HT','Hotel Management','R103',null)
SELECT * FROm Major

CREATE TABLE Student(
	ID char(8) primary key,
	Name nvarchar(30),
	MID char(3) null,
	Foreign Key(MID) references Major(ID) --khoá ngoại
)

insert into Student values ('SE123456', N'An Nguyễn', 'IS')
insert into Student values ('SE123457', N'Bình Lê', 'IS')
insert into Student values ('SE123458', N'Cường Võ', 'IS')
insert into Student values ('SE123459', N'Dũng Phạm', 'IS')

insert into Student values ('SE123460', N'Em Trần', 'JS')
insert into Student values ('SE123461', N'Giang Lê', 'JS')
insert into Student values ('SE123462', N'Hương Võ', 'JS') 
insert into Student values ('SE123463', N'Khanh Lê', 'JS') 

insert into Student values ('SE123464', N'Lan Trần', 'ES')
insert into Student values ('SE123465', N'Minh Lê', 'ES')
insert into Student values ('SE123466', N'Ninh Phạm', 'ES') 

insert into Student values ('SE123467', N'Oanh Phạm', 'JP')
insert into Student values ('SE123468', N'Phương Nguyễn', 'JP')

--IS: 4, JS: 4, ES: 3, JP: 2
--HT: 0, EN: 0
--3 sv đang học dự bị, tức là mã CN là null
insert into Student values ('SE123469', N'Quang Trần', null)
insert into Student values ('SE123470', N'Rừng Lê', null)
insert into Student values ('SE123471', N'Sơn Phạm', null)

SELECT * FROM Student
--liệt kê ds chuyên ngành kàm ds sinh viên học
--output: mã cn, tên cn, mã sv, tên sv

SELECT * FROM Major m left join Student s on m.ID = s.MID

--đảm bảo k mất cn nào
--mất 3 sv nhưng đủ yêu cầu đề
---
SELECT * FROM  Major m right join Student s on m.ID = s.MID
--mat chuyen nganh
SELECT * FROM  Major m full join Student s on m.ID = s.MID
--ko mat gi
SELECT * FROM  Major m inner join Student s on m.ID = s.MID
--mat ca 2

use convenienceStoreDB
--1. Mỗi khách hàng đã mua bao nhiêu đơn hàng
--Output 1: Mã customer, số đơn hàng
SELECT CustomerID, count(OrdID) as NumO FROM Orders GROUP BY CustomerID
--Output 2: Mã customer, tên customer, số đơn hàng  
SELECT c.CusID, count(o.OrdID) as NumO FROM Customer c left join Orders o on c.CusID = o.CustomerID GROUP BY CusID
SELECT tc.CusID, c.FirstName, NumO FROM (SELECT c.CusID, count(o.OrdID) as NumO FROM Customer c left join Orders o on c.CusID = o.CustomerID GROUP BY CusID) as tc left join Customer c ON tc.CusID = c.CusID
--**************************LƯU Ý***************************************
--nhớ rằng phải xác định table nào là góc, table nào là table bị kéo
--table góc sẽ hiển thị đầy đủ danh sách và thông tin của đối tượng
--chỉ nên lấy data của bên góc, khi cần hoặc gốc không có mới lấy data của phụ

--2. khác hàng nào mua nhiều đơn hàng nhất
--Output: Mã cty, tên cty, số đơn hàng  
SELECT * FROM Customer
SELECT o.CustomerID, c.FirstName, o.NumO FROM Customer c right join (SELECT CustomerID, count(OrdID) as NumO FROM Orders GROUP BY CustomerID HAVING count(OrdID) >=ALL(SELECT count(OrdID) FROM Orders GROUP BY CustomerID)) o on c.CusID = o.CustomerID
--nhớ rằng chơi kiểu này không thể lấy ra những thằng không mua hàng được
--phải join trước rồi mới group by thì sẽ lấy được giá trị 0 cho những thằng k mua hàng

--3. Mỗi nhân viên đã chăm sóc bao nhiêu đơn hàng
--Output 1: Mã nhân viên, số đơn hàng
SELECT EmpID, count(OrdID) as NumO FROM Orders GROUP BY EmpID
--Output 2: Mã nhân viên, tên nhân viên, số đơn hàng  
SELECT e.EmpID, e.FirstName, iif(tc.NumO is NULL,0,tc.NumO) as NumO FROM (SELECT EmpID, count(OrdID) as NumO FROM Orders GROUP BY EmpID) as tc right join Employee e on tc.EmpID = e.EmpID
--4. show ra ai(những ai) là khách hàng mua nhiều đơn hàng nhất 
SELECT CustomerID, count(OrdID) as NumO FROM Orders GROUP BY CustomerID HAVING count(OrdID) >=ALL(SELECT count(OrdID) FROM Orders GROUP BY CustomerID)
--5. show ra ai(những ai) là khách hàng mua ít đơn hàng nhất
SELECT CustomerID, count(OrdID) as NumO FROM Orders GROUP BY CustomerID HAVING count(OrdID) <=ALL(SELECT count(OrdID) FROM Orders GROUP BY CustomerID)