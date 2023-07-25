--03-OneManyRealationship
--quan hệ 1 nhiều
CREATE DATABASE DBK17F3_OneManyRelationship
USE DBK17F3_OneManyRelationship
----
--Cần lưu thông tin ứng viên đi thi
--Tạo table city
CREATE TABLE City(
	ID int not null,
	Name nvarchar(40),
)
ALTER TABLE City ADD CONSTRAINT PK_City primary key(ID)
ALTER TABLE City ADD CONSTRAINT UQ_City_Name unique(Name)
---------------
INSERT INTO City VALUES (1,N'TP.HCM')
INSERT INTO City VALUES (2,N'TP.Hà Nội')
INSERT INTO City VALUES (3,N'Bình Dương')
INSERT INTO City VALUES (4,N'Đắk Lắk')
INSERT INTO City VALUES (5,N'Bắc Kạn')
----------------
SELECT * FROM City
--------
CREATE TABLE Candidate(
	ID char(5) not null,
	LastName nvarchar(30) not null,
	FirstName nvarchar(15) not null,
	CityID int,
)

ALTER TABLE Candidate ADD CONSTRAINT PK_Candidate_ID primary key(ID)
ALTER TABLE Candidate ADD CONSTRAINT FK_Candidate_CityID_tblCityID foreign key(CityID) references City(ID)

INSERT INTO Candidate VALUES ('C1', N'Nguyễn', N'An',1)
INSERT INTO Candidate VALUES ('C2', N'Lê', N'Bình',1)
INSERT INTO Candidate VALUES ('C3', N'Võ', N'Cường',2)
INSERT INTO Candidate VALUES ('C4', N'Phạm', N'Dũng',3)
INSERT INTO Candidate VALUES ('C5', N'Trần', N'Em',4)
-----------
--1.Liệt Kê Danh Sách Sinh Viên
SELECT * FROM Candidate
--2.liệt kê danh sách sinh viên kèm theo thông tin thành phố
SELECT * FROM Candidate c LEFT JOIN City tp ON c.CityID = tp.ID
--2.1.Liệt kê danh sách các tĩnh kèm thông tin sinh viên
SELECT * FROM Candidate c RIGHT JOIN City tp ON c.CityID = tp.ID
--3. in ra các sinh viên ở thành phố hồ chí minh
SELECT * FROM Candidate 
WHERE CityID = (SELECT ID FROM City 
				WHERE Name = 'TP.HCM')
--4.đếm xem có bao nhiêu sinh viên
SELECT count(ID) as NumC FROM Candidate
--đếm xem mỗi tỉnh(thành phố) có bao nhiêu sinh viên
SELECT c.Name, tc.NumC FROM (
SELECT CityID, count(ID) as NumC FROM Candidate GROUP BY CityID) as tc right join City c on tc.CityID = c.ID

SELECT tp.*, tc.NumC FROM(SELECT ci.id, COUNT(ca.ID) as NumC FROM City ci left join Candidate ca ON ca.CityID = ci.ID GROUP BY ci.ID) as tc left join City tp ON tc.ID = tp.ID
--đếm xem thành phố hồ chí minh có bao nhiêu sinh viên
SELECT c.Name, tc.NumC FROM (
SELECT CityID, count(ID) as NumC FROM Candidate GROUP BY CityID 
							     HAVING CityID = (SELECT ID FROM City 
											      WHERE Name = 'TP.HCM')) as tc left join City c on tc.CityID = c.ID

SELECT tp.*, tc.NumC FROM(SELECT ci.id, COUNT(ca.ID) as NumC FROM City ci left join Candidate ca ON ca.CityID = ci.ID GROUP BY ci.ID) as tc left join City tp ON tc.ID = tp.ID WHERE tp.Name = 'TP.HCM'

--tĩnh nào nhiều sinh viên nhất
SELECT c.Name, tc.NumC FROM (
SELECT CityID, count(ID) as NumC FROM Candidate GROUP BY CityID 
								HAVING count(ID) >=ALL (SELECT count(ID) as NumC FROM Candidate GROUP BY CityID)) as tc left join City c on tc.CityID = c.ID

SELECT tp.*, tc.NumC FROM(SELECT ci.id, COUNT(ca.ID) as NumC FROM City ci left join Candidate ca ON ca.CityID = ci.ID GROUP BY ci.ID HAVING COUNT(ca.ID) >=ALL(SELECT COUNT(ca.ID) as NumC FROM City ci left join Candidate ca ON ca.CityID = ci.ID GROUP BY ci.ID)) as tc left join City tp ON tc.ID = tp.ID


---Hiện tượng đổ domino
--điều gì sẽ xảy ra kêu xoá 1 tỉnh trong table city
--City(1):Gốc -- SV(N):Nhánh
--Nếu bên 1 xoá thì bên N sẽ như thế nào
--và ngược lại?

--nếu xoá tp có mã là 1 thì sao
Delete City WHERE ID = '1'
--Bên 1 xoá thì bên N phải ko còn nhánh
---Trước tiên phải xoá nhánh trc khi xoá gốc
--đổi mã cảu bình dương từ 3 thành 333
UPDATE City SET ID = '333' WHERE ID = '3'
--Nếu update thì phải xoá nhánh trc mới up đc
--nếu xoá bên N thì bên 1 chẳng bị sao cả
------------------------V2-DOMINO--------
--Domino: tạo ra để xoá hay update thì dữ liệu sẽ ăn theo
CREATE TABLE CityV2(
	ID int not null,
	Name nvarchar(40),
)
ALTER TABLE CityV2 ADD CONSTRAINT PK_CityV2 primary key(ID)
ALTER TABLE CityV2 ADD CONSTRAINT UQ_CityV2_Name unique(Name)
---------------
INSERT INTO CityV2 VALUES (1,N'TP.HCM')
INSERT INTO CityV2 VALUES (2,N'TP.Hà Nội')
INSERT INTO CityV2 VALUES (3,N'Bình Dương')
INSERT INTO CityV2 VALUES (4,N'Đắk Lắk')
INSERT INTO CityV2 VALUES (5,N'Bắc Kạn')
----------------
SELECT * FROM CityV2
--------
CREATE TABLE CandidateV2(
	ID char(5) not null,
	LastName nvarchar(30) not null,
	FirstName nvarchar(15) not null,
	CityID int,
)

ALTER TABLE CandidateV2 ADD CONSTRAINT PK_CandidateV2_ID primary key(ID) 
ALTER TABLE CandidateV2 ADD CONSTRAINT FK_CandidateV2_CityID_tblCityV2ID foreign key(CityID) references CityV2(ID) ON DELETE SET null --nếu 1 xoá thì N bị null
																												   ON UPDATE CASCADE --nếu 1 update thì N ăn theo

INSERT INTO CandidateV2 VALUES ('C1', N'Nguyễn', N'An',1)
INSERT INTO CandidateV2 VALUES ('C2', N'Lê', N'Bình',1)
INSERT INTO CandidateV2 VALUES ('C3', N'Võ', N'Cường',2)
INSERT INTO CandidateV2 VALUES ('C4', N'Phạm', N'Dũng',3)
INSERT INTO CandidateV2 VALUES ('C5', N'Trần', N'Em',4)
---
DELETE CityV2 WHERE ID = '1'
SELECT * FROM CityV2
SELECT * FROM CandidateV2

DELETE CityV2 WHERE ID = '3'
UPDATE CityV2 SET ID = '222' WHERE ID = '2'






