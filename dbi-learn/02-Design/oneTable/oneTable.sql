--02-Design
 -- oneTable
	---01-oneTable.sql

CREATE DATABASE DBK17F2_OneTable
USE DBK17F2_OneTable

CREATE TABLE StudentV1(
	ID char(8),
	Name nvarchar(30),
	DOB date,  --yyyy/mm/dd
	Sex char(1),  --M,F,L,G,B,T,U
	Email varchar(50),
)

INSERT INTO StudentV1 VALUES('SE123456',N'An Nguyễn','1999-1-1', 'F', 'an@...')
INSERT INTO StudentV1 VALUES('SE123457','An Nguyễn','1999-1-1', 'F', 'an@...')
SELECT * FROM StudentV1
--
UPDATE StudentV1 set name = N'An Nguyễn' WHERE ID = 'SE123457'

--Đề xuất : mỗi cột table nên có 1 cột cấm trùng(key)
--Student(id,name,dob,phone,email,bằng lái xe, sổ hộ khẩu, cmnd)

--Trong table ta có thể có nhiều key: ID, email, cmnd
--Những key này gọi là candidate key : key ứng viên
--Mình phải chọn ra 1 trong đám đó để trở thành khoá chính(primary key)
---Khoá chính đc chọn dựa trên tiêu chí phù hợp vs bài toán lưu trữ của table
--  ko có tính khả dụng cao ở table khác
--Khoá chính là Primary Key(PK, default key)
--Primary Key(cấm trùng, cấm null)
--khoá chính là 1 cóntraint (ràng buộc)
--
CREATE TABLE StudentV2(
	ID char(8) PRIMARY KEY,
	Name nvarchar(30),
	DOB date,  --yyyy/mm/dd
	Sex char(1),  --M,F,L,G,B,T,U
	Email varchar(50),
)


INSERT INTO StudentV2 VALUES('SE123456',N'An Nguyễn','1999-1-1', 'F', 'an@...')
INSERT INTO StudentV2 VALUES('SE123457',null,null, null, null)

--làm v3 tạo ràng buộc null
CREATE TABLE StudentV3(
	ID char(8) PRIMARY KEY,
	Name nvarchar(30) not null,
	DOB date null,  --yyyy/mm/dd
	Sex char(1) null,  --M,F,L,G,B,T,U
	Email varchar(50) null,
)
INSERT INTO StudentV3 VALUES('SE123457',null,null, null, null)
INSERT INTO StudentV3 VALUES('SE123457',N'Bình Lê',null, null, null)

INSERT INTO StudentV3(id, name) VALUES('SE123457',N'Bình Lê')
---chèn thiếu cột
--Name
--Điệp Lê
--John Wick
--Nguyễn Tuân
CREATE TABLE StudentV4(
	ID char(8) PRIMARY KEY,
	FirstName nvarchar(15) not null,
	LastName nvarchar(30) not null,
	DOB date null,  --yyyy/mm/dd
	Sex char(1) null,  --M,F,L,G,B,T,U
	Email varchar(50) null,
)

INSERT INTO StudentV4 (id, FirstName, LastName) VALUES ('SE123456',N'An',N'Nguyễn')
INSERT INTO StudentV4 (id, FirstName, LastName) VALUES ('SE123457', N'Đặng',N'Jonny')
INSERT INTO StudentV4 (id, FirstName, LastName) VALUES ('SE123458', N'Bình',N'Lê')

SELECT * FROM StudentV4 ORDER BY FirstName ASC

--Rằng buộc là cách ta ép ng dùng nhập data theo 1 chuẩn nào đó
--Vidu: Sex phải M F L G B T U
-------Tên ko đc bỏ trống
-------ID cấm trùng
-------ID bên table này phải xuất hiện bên table khác
-------Sv ko đc đăng ký quá 5 môn
--Trong table có những loại ràng buộc nào
----Primary key (khoá chính, not null, cấm trùng)
----Unique   (cấm trùng, null or ko cx đc)
----not null (cấm null)
----foreign key(khoá ngoại ràng buộc tham chiếu)
----default (giá trị mặc định
----check (coi giá trị nằm trong khoảng yêu cầu)

--Trong quá trình thiết ké database mọta table có thể có nhiều ràng buộc
--Nên đặt tên cho ràng buộc -> để dễ quản lý và xoá khi cần

---R101 + Anna
---composite key (key kết hợp)
--2 cột ko đủ sức để định vị đối tượng, nếu kết hợp lại thì đc ta có thể dùng composite key
--primary(ROOM, BLOCK)

--Super key (Vô dụng)
--Super là composite key (PK, cột khác)

--StudentV5: đặt tên ràng buộc
CREATE TABLE StudentV5(
	ID char(8) not null,
	FirstName nvarchar(15) not null,
	LastName nvarchar(30) not null,
	DOB date null,  --yyyy/mm/dd
	Sex char(1) null,  --M,F,L,G,B,T,U
	Email varchar(50) null,
	--primary key(ID, ..) -- ko nên
)

ALTER TABLE StudentV5
	ADD CONSTRAINT PK_StudentV5_ID primary key (ID)
ALTER TABLE StudentV5
	ADD CONSTRAINT UQ_StudentV5_Email unique (Email)


INSERT INTO StudentV5(ID, FirstName, LastName) VALUES ('SE123456', N'An',N'Nguyễn')
SELECT * FROM StudentV5


