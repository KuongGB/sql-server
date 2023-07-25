--02-JoinAggregate
--1. ta thiết kế database lưu trữ thông tin sv
--và chuyên ngành sv đó học
--mô tả:
--chuyên ngành gồm : mã cn, tên cn, room, hotline
--vd: JP   Ngôn Ngữ nhật   R102   098x...
---có tình trạng trường mở ra cn nhưng ko ai học

--thông tin sv: mã sv, tên, mã chuyên ngành sv học
--
CREATE DATABASE DBK17F3_Ch04_JoinAggregate
USE DBK17F3_Ch04_JoinAggregate

---
CREATE TABLE Major(
	ID char(3) Primary key,
	Name nvarchar(30) not null,
	Room char(5) null,
	Hotline char(11) null,
)

insert into Major values('IS','Information System','R101','091x...')
insert into Major values('JS','Japanese Software Eng','R102','091x...')
insert into Major values('ES','Embedded System','R103',null)
insert into Major values('JP','Japanese Language','R104','091x...')
insert into Major values('EN','English','R105','091x...')
insert into Major values('HT','Hotel Management','R106','091x...')
insert into Major values('IA','Information Asurance','R103',null)

SELECT * FROM Major

CREATE TABLE Student(
	ID char(9) Primary Key,
	Name nvarchar(30) not null,
	MID char(3)  null,
	Foreign Key (MID) References Major(ID)
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

insert into Student values ('SE123472', N'Anh Lê', 'IA')
--IS: 4, JS: 4, ES: 3, JP: 2
--HT: 0, EN: 0
--3 sv đang học dự bị, tức là mã CN là null
insert into Student values ('SE123469', N'Quang Trần', null)
insert into Student values ('SE123470', N'Rừng Lê', null)
insert into Student values ('SE123471', N'Sơn Phạm', null)

------------------
--1. Có bao nhiêu chuyên ngành  --6rows
SELECT count(ID) as NumM FROM Major
--2. Có bao nhiêu sinh viên
SELECT count(ID) as NumS FROM Student
--3. Có bao nhiêu sv học chuyên ngành IS
SELECT count(ID) as NumS FROM Student WHERE MID = 'IS'
--4. Đếm xem mỗi CN có bao nhiêu SV
SELECT m.ID, count(s.ID) as NumS FROM Major m left join Student s on m.ID = s.MID GROUP BY m.ID
--5. Chuyên ngành nào có nhiều SV nhất
--xử lý 2 cn không có sinh viên bằng iff trước khi tìm max min
SELECT m.id, count(s.id) as NumS FROM Major m left join Student s on m.id = s.MID GROUP BY m.ID Having count(s.id) >=ALL(SELECT count(s.ID) as NumS FROM Major m left join Student s on m.ID = s.MID GROUP BY m.ID) 
--6. Chuyên ngành nào có ít sv nhất
--<= ALL:
SELECT m.id, count(s.id) as NumS FROM Major m left join Student s on m.id = s.MID GROUP BY m.ID Having count(s.id) <=ALL(SELECT count(s.ID) as NumS FROM Major m left join Student s on m.ID = s.MID GROUP BY m.ID)
--dùng min:
SELECT m.id, count(s.id) as NumS FROM Major m left join Student s on m.id = s.MID GROUP BY m.ID HAVING count(s.ID) = (
SELECT min(NumS) FROM (SELECT m.id, count(s.id) as NumS FROM Major m left join Student s on m.id = s.MID GROUP BY m.ID) as tc)

--7. Đếm số sv của cả 2 chuyên ngành ES và JS 
--dùng Where + aggregate: 
SELECT count(ID) as NumS FROM Student WHERE MID in ('ES', 'JS')
--dùng Group by + MultipleColum + sum : 
SELECT sum(NumS) FROM (SELECT m.ID, count(s.ID) as NumS FROM Major m left join Student s ON m.ID = s.MID GROUP BY m.ID Having m.ID in ('ES', 'JS')) as tc
---
SELECT sum(NumS) as NumS FROM (SELECT MID, count(ID) as NumS FROM Student GROUP BY MID Having MID in ('ES', 'JS')) as tc
--8. Mỗi chuyên ngành ES và JS có bao nhiêu sv
SELECT m.ID, count(s.ID) as NumS FROM Major m left join Student s ON m.ID = s.MID GROUP BY m.ID Having m.ID in ('ES', 'JS')
---
SELECT MID, count(ID) as NumS FROM Student WHERE MID in ('ES', 'JS') GROUP BY MID
--9. Chuyên ngành nào có từ 3 sv trở lên
SELECT m.ID, count(s.ID) as NumS FROM Major m left join Student s ON m.ID = s.MID GROUP BY m.ID Having count(s.ID) >= 3		
--10. Chuyên ngành nào có từ 2 sv trở xuống
SELECT m.ID, count(s.ID) as NumS FROM Major m left join Student s ON m.ID = s.MID GROUP BY m.ID Having count(s.ID) <= 2 
--11. Liệt kê danh sách sv của mỗi CN
--output: mã cn, tên cn, mã sv, tên sv
SELECT m.ID, m.Name, s.ID, s.Name FROM Student s right join Major m on s.MID = m.ID

--12. Liệt kê thông tin chuyên ngành của mỗi sv
--output: mã sv, tên sv, mã cn, tên cn, room
SELECT s.ID, s.Name, m.ID, m.Name, m.Room FROM Major m right join Student s on m.ID = s.MID
--thử thách làm lại câu 13 siêu khó của bài MaxMinSumAll


---===========================
--BaiTap
Use convenienceStoreDB
--1. đếm xem mỗi nhà vận chuyển đã vận chuyển bao nhiêu đơn hàng ?
--output: mã nhà vận chuyển, tên nhà vận chuyển, số lượng đơn hàng
SELECT tc.ShipID, s.CompanyName, tc.NumO FROM (
SELECT s.ShipID, count(OrdID) as NumO FROM Shipper s left join Orders o on s.ShipID = o.ShipID GROUP BY s.ShipID) as tc left join Shipper s on tc.ShipID = s.ShipID
--2. đếm xem mỗi nhà vận chuyển đã vận chuyển bao nhiêu đơn hàng đến USA?
--output: mã nhà vận chuyển, tên nhà vận chuyển, số lượng đơn hàng
SELECT tc.ShipID, s.CompanyName, tc.NumO FROM (
SELECT s.ShipID, count(OrdID) as NumO FROM Shipper s left join Orders o on s.ShipID = o.ShipID  WHERE ShipCountry = 'USA' GROUP BY s.ShipID ) as tc left join Shipper s on tc.ShipID = s.ShipID
--3. Khách hàng CUS001 , CUS005, CUS007 dã mua bao nhiêu đơn hàng
--output: mã khách hàng, tên khách hàng, số lượng khách hàng 
SELECT c.CusID,count(OrdID) as NumO FROM Customer c left join Orders o ON c.CusID = o.CustomerID WHERE CustomerID in ('CUS001', 'CUS005', 'CUS007') GROUP BY c.CusID
---
SELECT tc.CusID, c.FirstName, tc.NumO FROM (SELECT c.CusID,count(OrdID) as NumO FROM Customer c left join Orders o ON c.CusID = o.CustomerID GROUP BY c.CusID HAVING CusID in ('CUS001', 'CUS005', 'CUS007')) as tc left join Customer c ON tc.CusID = c.CusID
--4. Khách hàng CUS001 , CUS005, CUS007 dã mua bao nhiêu đơn hàng vận chuyển tới đúng quê của họ
--output: mã khách hàng, tên khách hàng, số lượng khách hàng
SELECT tc.CusID, c.FirstName, c.Country, tc.NumO FROM (
SELECT c.CusID,count(OrdID) as NumO FROM Customer c left join Orders o ON c.CusID = o.CustomerID AND c.Country = o.ShipCountry 
									GROUP BY c.CusID HAVING CusID in ('CUS001', 'CUS005','CUS007')) as tc left join Customer c ON tc.CusID = c.CusID

--Ans: 001 UK 6, 005 USA 2, 007 UK 0